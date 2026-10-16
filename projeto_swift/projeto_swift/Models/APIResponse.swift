import Foundation

struct RespostaAPI: Decodable {
    let imagem: URL
    let especie: String

    enum CodingKeys: String, CodingKey {
        case imagem = "img"
        case especie = "species"
    }
}
