import SwiftUI

struct WelcomeView: View {
    var onNext: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            
            Image("phone") // A imagem de fundo do telefone
                .resizable()
                .scaledToFit()
                .frame(height: 600) // Ajuste conforme o necessário
                .position(x: 100, y: 400) // Move a imagem para a esquerda e um pouco para baixo
            
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150) // Tamanho do logo
                    .position(x: 80, y: 600)
                
                Text("The easiest way to escape it all.")
                    .font(Font.custom("ProximaNova-Regular", size: 24))
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                Spacer()
                
                // Botão NEXT
                HStack {
                    Spacer()
                    Button(action: {
                        onNext()
                    }) {
                        Text("NEXT →")
                            .font(Font.custom("ProximaNova-Bold", size: 24))
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                }
            }
            .padding(.horizontal, 30) // Adiciona espaçamento horizontal
            .padding(.bottom, 100) // Adiciona espaçamento inferior
        }
    }
}
