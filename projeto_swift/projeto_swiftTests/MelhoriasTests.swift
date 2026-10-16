import XCTest
@testable import projeto_swift

@MainActor
final class MelhoriasTests: XCTestCase {
    func testRespostaPreservaCamposDaAPI() throws {
        let dados = Data(#"{"img":"https://example.com/foto.jpg","species":"emperor"}"#.utf8)
        let resposta = try JSONDecoder().decode(RespostaAPI.self, from: dados)
        XCTAssertEqual(resposta.especie, "emperor")
        XCTAssertEqual(resposta.imagem.absoluteString, "https://example.com/foto.jpg")
    }

    func testBuscaFotosReaisDasSeisCategorias() async throws {
        XCTAssertEqual(Categoria.allCases.count, 6)
        for categoria in Categoria.allCases {
            let pinguins = try await ServicoPinguins().buscar(categoria: categoria)
            XCTAssertFalse(pinguins.isEmpty)
            XCTAssertLessThanOrEqual(pinguins.count, 5)
            XCTAssertTrue(pinguins.allSatisfy { $0.especie == categoria.rawValue })
            XCTAssertTrue(pinguins.allSatisfy { !$0.habitat.isEmpty && $0.fonteHabitat != nil })
        }
    }
}
