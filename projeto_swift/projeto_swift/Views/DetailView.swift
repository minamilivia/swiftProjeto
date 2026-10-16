import SwiftUI

struct TelaDetalhes: View {
    let pinguim: Pinguim
    @State private var fotoDisponivel = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                if fotoDisponivel {
                    ImagemRemota(endereco: pinguim.enderecoImagem) {
                        fotoDisponivel = false
                    }
                    .frame(height: 360)
                    .accessibilityLabel("Foto de \(pinguim.nome)")
                }
                Text(pinguim.nome)
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                VStack(alignment: .leading, spacing: 16) {
                    Label("Onde habita", systemImage: "mappin.and.ellipse")
                        .font(.headline)
                        .foregroundStyle(Tema.oceano)
                    Text(pinguim.regiao).font(.title3.bold())
                    Text(pinguim.habitat)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    if let fonte = pinguim.fonteHabitat {
                        Link(destination: fonte) {
                            Label("Fonte sobre o habitat", systemImage: "arrow.up.right.square")
                                .font(.footnote)
                        }
                    }
                }
                .padding(22)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.background, in: RoundedRectangle(cornerRadius: 24))
            }
            .padding(24)
        }
        .background(Tema.fundo)
        .navigationTitle("Conheça a espécie")
        .navigationBarTitleDisplayMode(.inline)
    }
}
