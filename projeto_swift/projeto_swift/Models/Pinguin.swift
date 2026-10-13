import SwiftUI

struct Pinguin:Decodable,Hashable{
    let nome: String;
    let imagem:URL;
    
    init(nome:String,imagem:URL){
        self.nome = nome;
        self.imagem = imagem;
    }
}
