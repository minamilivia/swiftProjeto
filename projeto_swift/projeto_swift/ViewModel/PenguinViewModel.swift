import Foundation
import Observation

@MainActor
@Observable
final class PinguinsViewModel {
    private(set) var pinguins: [Pinguim] = []
    private(set) var estaCarregando = false
    private(set) var mensagemErro: String?
    private(set) var carregou = false
    private let servico = ServicoPinguins()

    func carregar(categoria: Categoria) async {
        guard !estaCarregando else { return }
        estaCarregando = true
        mensagemErro = nil
        defer { estaCarregando = false }
        do {
            let resultados = try await servico.buscar(categoria: categoria)
            try Task.checkCancellation()
            pinguins = resultados
            carregou = true
        } catch is CancellationError {
        } catch let erro as URLError where erro.code == .cancelled {
        } catch let erro as ErroPinguins {
            mensagemErro = erro.localizedDescription
        } catch {
            mensagemErro = "Não foi possível carregar as fotos. Confira sua conexão e tente novamente."
        }
    }

    func removerFoto(endereco: URL) {
        pinguins.removeAll { $0.enderecoImagem == endereco }
    }
}
