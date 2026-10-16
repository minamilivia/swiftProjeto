import Foundation

struct Pinguim: Identifiable, Hashable {
    let id: UUID
    let enderecoImagem: URL
    let especie: String

    var categoria: Categoria? { Categoria(rawValue: especie) }
    var nome: String { categoria?.titulo ?? especie.replacingOccurrences(of: "_", with: " ").capitalized }
    var regiao: String { categoria?.regiao ?? "Região não informada" }
    var habitat: String { categoria?.habitat ?? "Não há informações verificadas sobre este habitat." }
    var fonteHabitat: URL? { categoria?.fonteHabitat }
}
