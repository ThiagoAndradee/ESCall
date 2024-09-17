import SwiftUI
import AVKit

struct TutorialView: View {
    var onNext: () -> Void // Closure para a navegação

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            
            VStack(alignment: .leading) {
                Image("logoopacity") // Seu logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top, 50)
                
                Text("Easy and quick")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Text("The call is triggered by quickly pressing the volume up ( 1 ), volume down ( 2 ) and volume up ( 3 ).")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                Spacer()

                // Reproduzir o vídeo MP4 com um frame específico
                VideoView(videoName: "tutorial")
                    .frame(width: 300, height: 500) // Ajuste o tamanho do vídeo
                    .padding(.leading, 25)

                Spacer()
                
                HStack {
                    Spacer() // Espaço à esquerda

                    Button(action: {
                        onNext() // Ação que chama a navegação
                    }) {
                        Text("START")
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

                    Spacer() // Espaço à direita
                }

                .padding(.bottom, 50)
            }
            .padding(.horizontal, 20)
        }
    }
}
