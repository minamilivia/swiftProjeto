import SwiftUI

struct ImagemRemota: View {
    let endereco: URL
    var aoFalhar: () -> Void = {}

    var body: some View {
        GeometryReader { tamanho in
            AsyncImage(url: endereco) { fase in
                switch fase {
                case .empty:
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .success(let imagem):
                    imagem.resizable().scaledToFill()
                case .failure:
                    Color.clear.task { aoFalhar() }
                @unknown default:
                    Color.clear.task { aoFalhar() }
                }
            }
            .frame(width: tamanho.size.width, height: tamanho.size.height)
            .clipped()
        }
        .background(Tema.oceano.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}
