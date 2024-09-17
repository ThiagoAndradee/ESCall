import SwiftUI

struct CallInProgressView: View {
    @State private var callDuration: Int = 0
    @State private var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Fundo preto
            
            VStack {
                Text("Call in Progress")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Spacer()
                
                // Temporizador da chamada
                Text(formatTime(callDuration))
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                Spacer()
                
                // Botão de desligar
                Button(action: {
                    endCall()
                }) {
                    Image(systemName: "phone.down.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.red)
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    // Função para iniciar o timer
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            callDuration += 1
        }
    }
    
    // Função para parar o timer
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // Função para encerrar a chamada
    func endCall() {
        stopTimer()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = UIHostingController(rootView: HomeView())
            window.makeKeyAndVisible()
        }
    }
    
    // Formatar o tempo em minutos e segundos
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct CallInProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CallInProgressView()
    }
}
