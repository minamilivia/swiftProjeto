import Foundation

enum Categoria: String, CaseIterable, Identifiable, Hashable {
    case imperador = "emperor"
    case barbicha = "chinstrap"
    case magalhaes = "magellanic"
    case humboldt = "humboldt"
    case cristaEreta = "erect-crested"
    case real = "royal"

    var id: String { rawValue }

    var titulo: String {
        switch self {
        case .imperador: return "Pinguim-imperador"
        case .barbicha: return "Pinguim-de-barbicha"
        case .magalhaes: return "Pinguim-de-magalhães"
        case .humboldt: return "Pinguim-de-humboldt"
        case .cristaEreta: return "Pinguim-de-crista-ereta"
        case .real: return "Pinguim-real"
        }
    }

    var simbolo: String {
        switch self {
        case .imperador: return "snowflake"
        case .barbicha: return "mountain.2.fill"
        case .magalhaes: return "water.waves"
        case .humboldt: return "sun.horizon.fill"
        case .cristaEreta: return "wind"
        case .real: return "sparkles"
        }
    }

    var regiao: String {
        switch self {
        case .imperador: return "Antártida"
        case .barbicha: return "Península Antártica e ilhas próximas"
        case .magalhaes: return "Litoral sul da América do Sul"
        case .humboldt: return "Costas do Peru e do Chile"
        case .cristaEreta: return "Ilhas Antípodas e Bounty"
        case .real: return "Ilha Macquarie e ilhotas próximas"
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
        case .humboldt:
            return "Vive na costa do Pacífico do Peru e do Chile, em águas influenciadas pela corrente fria de Humboldt. Reproduz-se em ilhas e áreas costeiras, utilizando tocas e abrigos para os ninhos."
        case .cristaEreta:
            return "Reproduz-se nas ilhas Antípodas e Bounty, na região subantártica da Nova Zelândia. Essas ilhas abrigam os únicos locais conhecidos de reprodução da espécie, que utiliza o ambiente marinho ao redor para buscar alimento."
        case .real:
            return "Reproduz-se na ilha Macquarie e nas ilhotas próximas Bishop e Clerk, na região subantártica. Forma colônias em praias e encostas e busca alimento no mar."
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
        case .humboldt:
            return URL(string: "https://www.fws.gov/species/humboldt-penguin-spheniscus-humboldti")
        case .cristaEreta:
            return URL(string: "https://www.doc.govt.nz/parks-and-recreation/places-to-go/southland/places/subantarctic-islands/antipodes-islands/antipodes-island-moutere-mahue-marine-reserve/")
        case .real:
            return URL(string: "https://www.antarctica.gov.au/about-antarctica/animals/penguins/royal-penguin/")
        }
    }
}
