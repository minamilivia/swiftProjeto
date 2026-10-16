import SwiftUI

struct CartaoPinguim: View {
    let pinguim: Pinguim
    var aoFalharImagem: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ImagemRemota(endereco: pinguim.enderecoImagem, aoFalhar: aoFalharImagem)
                .frame(height: 290)
                .accessibilityLabel("Foto de \(pinguim.nome)")
            VStack(alignment: .leading, spacing: 8) {
                Text(pinguim.nome)
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundStyle(.primary)
                Label(pinguim.regiao, systemImage: "mappin.and.ellipse")
                    .font(.subheadline)
                    .foregroundStyle(Tema.oceano)
            }
            HStack {
                Text("Conhecer habitat")
                Spacer()
                Image(systemName: "arrow.right")
            }
            .font(.subheadline.bold())
            .foregroundStyle(.white)
            .padding(16)
            .background(Tema.oceano, in: RoundedRectangle(cornerRadius: 18))
        }
        .padding(16)
        .background(.background, in: RoundedRectangle(cornerRadius: 30))
        .shadow(color: Tema.oceano.opacity(0.14), radius: 10, y: 5)
    }
}
