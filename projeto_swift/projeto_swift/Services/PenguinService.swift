import Foundation
import ImageIO

enum ErroPinguins: LocalizedError {
    case semFotos

    var errorDescription: String? {
        "Não encontramos fotos disponíveis agora. Tente novamente em instantes."
    }
}

struct ServicoPinguins {
    func buscar(categoria: Categoria) async throws -> [Pinguim] {
        var componentes = URLComponents(string: "https://penguin.sjsharivker.workers.dev/api")
        componentes?.queryItems = [URLQueryItem(name: "species", value: categoria.rawValue)]
        guard let endereco = componentes?.url else { throw URLError(.badURL) }
        var pinguins: [Pinguim] = []
        var fotosValidas = Set<URL>()
        var fotosInvalidas = Set<URL>()
        var ultimoErro: Error = ErroPinguins.semFotos

        for _ in 0..<15 {
            try Task.checkCancellation()
            do {
                let (dados, resposta) = try await URLSession.shared.data(from: endereco)
                try validar(resposta)
                let resultado = try JSONDecoder().decode(RespostaAPI.self, from: dados)
                let enderecoImagem = corrigirEndereco(resultado.imagem, especie: resultado.especie)
                guard resultado.especie == categoria.rawValue,
                      enderecoImagem.scheme == "https",
                      !fotosInvalidas.contains(enderecoImagem) else { continue }

                if !fotosValidas.contains(enderecoImagem) {
                    do {
                        let (foto, respostaFoto) = try await URLSession.shared.data(from: enderecoImagem)
                        try validar(respostaFoto)
                        guard let origem = CGImageSourceCreateWithData(foto as CFData, nil),
                              CGImageSourceCreateImageAtIndex(origem, 0, nil) != nil else {
                            fotosInvalidas.insert(enderecoImagem)
                            continue
                        }
                        let requisicao = URLRequest(url: enderecoImagem)
                        URLCache.shared.storeCachedResponse(
                            CachedURLResponse(response: respostaFoto, data: foto),
                            for: requisicao
                        )
                        fotosValidas.insert(enderecoImagem)
                    } catch {
                        try Task.checkCancellation()
                        ultimoErro = error
                        fotosInvalidas.insert(enderecoImagem)
                        continue
                    }
                }

                pinguins.append(Pinguim(id: UUID(), enderecoImagem: enderecoImagem, especie: resultado.especie))
                if pinguins.count == 5 { break }
            } catch {
                try Task.checkCancellation()
                ultimoErro = error
                if let erro = error as? URLError,
                   [.notConnectedToInternet, .networkConnectionLost, .timedOut, .cannotFindHost, .cannotConnectToHost].contains(erro.code) {
                    break
                }
            }
        }
        guard !pinguins.isEmpty else { throw ultimoErro }
        return pinguins
    }

    private func corrigirEndereco(_ endereco: URL, especie: String) -> URL {
        guard especie == "erect-crested",
              var componentes = URLComponents(url: endereco, resolvingAgainstBaseURL: false) else {
            return endereco
        }
        componentes.path = componentes.path.replacingOccurrences(
            of: "/img/erect-crested/",
            with: "/img/erect_crested/"
        )
        return componentes.url ?? endereco
    }

    private func validar(_ resposta: URLResponse) throws {
        guard let respostaHTTP = resposta as? HTTPURLResponse,
              (200...299).contains(respostaHTTP.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
