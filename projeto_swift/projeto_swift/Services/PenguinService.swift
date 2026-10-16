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
                guard resultado.especie == categoria.rawValue,
                      resultado.imagem.scheme == "https",
                      !fotosInvalidas.contains(resultado.imagem) else { continue }

                if !fotosValidas.contains(resultado.imagem) {
                    do {
                        let (foto, respostaFoto) = try await URLSession.shared.data(from: resultado.imagem)
                        try validar(respostaFoto)
                        guard let origem = CGImageSourceCreateWithData(foto as CFData, nil),
                              CGImageSourceCreateImageAtIndex(origem, 0, nil) != nil else {
                            fotosInvalidas.insert(resultado.imagem)
                            continue
                        }
                        let requisicao = URLRequest(url: resultado.imagem)
                        URLCache.shared.storeCachedResponse(
                            CachedURLResponse(response: respostaFoto, data: foto),
                            for: requisicao
                        )
                        fotosValidas.insert(resultado.imagem)
                    } catch {
                        try Task.checkCancellation()
                        ultimoErro = error
                        fotosInvalidas.insert(resultado.imagem)
                        continue
                    }
                }

                pinguins.append(Pinguim(id: UUID(), enderecoImagem: resultado.imagem, especie: resultado.especie))
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

    private func validar(_ resposta: URLResponse) throws {
        guard let respostaHTTP = resposta as? HTTPURLResponse,
              (200...299).contains(respostaHTTP.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
