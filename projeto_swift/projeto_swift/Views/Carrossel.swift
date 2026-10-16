import SwiftUI

struct TelaCarrossel: View {
    let categoria: Categoria
    @State private var modelo = PinguinsViewModel()
    @State private var identificadorSelecionado: UUID?

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 24) {
                VStack(spacing: 6) {
                    Text("Um olhar mais de perto")
                        .font(.title2.bold())
                    Text("Deslize pelas fotos e explore o habitat.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 24)

                if modelo.estaCarregando {
                    ProgressView("Buscando fotos...")
                        .padding(.vertical, 100)
                } else if let mensagem = modelo.mensagemErro {
                    aviso(mensagem)
                } else if modelo.carregou && modelo.pinguins.isEmpty {
                    aviso("Não há fotos disponíveis no momento. Tente novamente.")
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(modelo.pinguins) { pinguim in
                                NavigationLink(value: pinguim) {
                                    CartaoPinguim(pinguim: pinguim) {
                                        modelo.removerFoto(endereco: pinguim.enderecoImagem)
                                    }
                                }
                                .buttonStyle(.plain)
                                .containerRelativeFrame(.horizontal)
                                .id(pinguim.id)
                            }
                        }
                        .scrollTargetLayout()
                        .padding(.vertical, 16)
                    }
                    .contentMargins(.horizontal, 32, for: .scrollContent)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $identificadorSelecionado)

                    HStack(spacing: 10) {
                        ForEach(modelo.pinguins) { pinguim in
                            Circle()
                                .fill(corIndicador(para: pinguim))
                                .frame(width: 9, height: 9)
                        }
                    }
                    .accessibilityLabel("\(modelo.pinguins.count) fotos disponíveis")
                    Label("Deslize para explorar", systemImage: "arrow.left.and.right")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    if modelo.pinguins.count < 5 && !modelo.pinguins.isEmpty {
                        Text("Mostrando \(modelo.pinguins.count) fotos disponíveis.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.vertical, 24)
        }
        .background(Tema.fundo)
        .navigationTitle(categoria.titulo)
        .navigationBarTitleDisplayMode(.inline)
        .task(id: categoria) {
            if !modelo.carregou { await modelo.carregar(categoria: categoria) }
        }
        .onChange(of: modelo.pinguins.map(\.id)) { _, identificadores in
            if identificadorSelecionado == nil || !identificadores.contains(identificadorSelecionado!) {
                identificadorSelecionado = identificadores.first
            }
        }
    }

    private func corIndicador(para pinguim: Pinguim) -> Color {
        let atual = identificadorSelecionado ?? modelo.pinguins.first?.id
        return atual == pinguim.id ? Tema.oceano : Tema.oceano.opacity(0.2)
    }

    private func aviso(_ mensagem: String) -> some View {
        VStack(spacing: 18) {
            Text(mensagem).multilineTextAlignment(.center)
            Button("Tentar novamente") {
                Task { await modelo.carregar(categoria: categoria) }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(32)
    }
}
