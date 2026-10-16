import Foundation

enum Categoria: String, CaseIterable, Identifiable, Hashable {
    case imperador = "emperor"
    case barbicha = "chinstrap"
    case magalhaes = "magellanic"

    var id: String { rawValue }

    var titulo: String {
        switch self {
        case .imperador: return "Pinguim-imperador"
        case .barbicha: return "Pinguim-de-barbicha"
        case .magalhaes: return "Pinguim-de-magalhães"
        }
    }

    var simbolo: String {
        switch self {
        case .imperador: return "snowflake"
        case .barbicha: return "mountain.2.fill"
        case .magalhaes: return "water.waves"
        }
    }

    var regiao: String {
        switch self {
        case .imperador: return "Antártida"
        case .barbicha: return "Península Antártica e ilhas próximas"
        case .magalhaes: return "Litoral sul da América do Sul"
        }
    }

    var habitat: String {
        switch self {
        case .imperador:
            return "Vive nas águas e no gelo ao redor da Antártida. A maioria das colônias se reproduz sobre gelo marinho fixo junto à costa, entre ilhas ou icebergs encalhados."
        case .barbicha:
            return "Reproduz-se principalmente na Península Antártica e em ilhas do Atlântico Sul. Forma colônias em terra, incluindo terrenos rochosos, e busca alimento nas águas próximas à costa."
        case .magalhaes:
            return "Habita costas e ilhas do sul da América do Sul, com colônias reprodutivas na Argentina e no Chile. Fora da reprodução, acompanha o alimento pelo litoral, podendo alcançar o Brasil no Atlântico e o Peru no Pacífico."
        }
    }

    var fonteHabitat: URL? {
        switch self {
        case .imperador:
            return URL(string: "https://www.antarctica.gov.au/about-antarctica/animals/penguins/emperor-penguin/")
        case .barbicha:
            return URL(string: "https://www.antarctica.gov.au/about-antarctica/animals/penguins/chinstrap-penguin/")
        case .magalhaes:
            return URL(string: "https://www.aquariumofpacific.org/exhibits/penguin_habitat/magellanic_penguins")
        }
    }
}
