import SwiftUI

enum Tema {
    static let oceano = Color(red: 0.10, green: 0.45, blue: 0.57)
    static let fundo = Color(red: 0.94, green: 0.97, blue: 0.98)
}

struct TelaInicial: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("UMA VIAGEM PELOS OCEANOS", systemImage: "globe.americas.fill")
                            .font(.caption.weight(.bold))
                            .tracking(1.5)
                            .foregroundStyle(Tema.oceano)
                        Text("Mundo dos\npinguins")
                            .font(.system(size: 42, weight: .heavy, design: .rounded))
                            .foregroundStyle(Color.primary)
                        Text("Conheça cada espécie e descubra onde ela vive.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    HStack(spacing: 20) {
                        Image(systemName: "water.waves")
                            .font(.system(size: 42, weight: .light))
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Do gelo ao litoral")
                                .font(.title3.bold())
                            Text("Escolha uma espécie para começar a explorar.")
                                .font(.subheadline)
                        }
                    }
                    .foregroundStyle(.white)
                    .padding(24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Tema.oceano.gradient, in: RoundedRectangle(cornerRadius: 28))

                    VStack(alignment: .leading, spacing: 14) {
                        Text("Escolha uma espécie")
                            .font(.title2.bold())
                        ForEach(Categoria.allCases) { categoria in
                            NavigationLink(value: categoria) {
                                HStack(spacing: 16) {
                                    Image(systemName: categoria.simbolo)
                                        .font(.title2)
                                        .frame(width: 58, height: 64)
                                        .background(Tema.oceano.opacity(0.09), in: RoundedRectangle(cornerRadius: 18))
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(categoria.titulo)
                                            .font(.headline)
                                            .foregroundStyle(.primary)
                                        Text(categoria.regiao)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer(minLength: 0)
                                    Image(systemName: "arrow.up.right")
                                        .font(.subheadline.bold())
                                }
                                .foregroundStyle(Tema.oceano)
                                .padding(16)
                                .background(.background, in: RoundedRectangle(cornerRadius: 24))
                                .shadow(color: Tema.oceano.opacity(0.06), radius: 12, y: 5)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(24)
            }
            .background(Tema.fundo)
            .navigationTitle("Explorar")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Categoria.self) { categoria in
                TelaCarrossel(categoria: categoria)
            }
            .navigationDestination(for: Pinguim.self) { pinguim in
                TelaDetalhes(pinguim: pinguim)
            }
        }
        .tint(Tema.oceano)
    }
}
