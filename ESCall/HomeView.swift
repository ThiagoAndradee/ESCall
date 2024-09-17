import SwiftUI
import AVFoundation

struct HomeView: View {
    @State private var isActive = false // Controla o estado de ativação
    @State private var volumeButtonHandler: VolumeButtonHandler? = nil // Handler de botões de volume
    @State private var audioPlayer: AVAudioPlayer? // Para tocar o áudio personalizado
    
    var body: some View {
        ZStack {
            if isActive {
                VolumeButtonHandler(isActive: $isActive, audioPlayer: $audioPlayer)
            }
            
            Image("bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 50)
                    .padding(.top, 50)
                
                ZStack {
                    Image(isActive ? "activeState" : "deactiveState")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                    
                    Image("phone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .padding(.top, 80)
                }
                
                Button(action: {
                    isActive.toggle()
                    if isActive {
                        volumeButtonHandler = VolumeButtonHandler(isActive: $isActive, audioPlayer: $audioPlayer)
                    } else {
                        volumeButtonHandler = nil
                    }
                }) {
                    Image(isActive ? "deactivate" : "activate")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 50)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    triggerFakeCall()
                }) {
                    Text("Test Fake Call")
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
                .padding(.bottom, 50)
            }
        }
    }
    
    func triggerFakeCall() {
        playRingtone()
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = UIHostingController(rootView: FakeCallView(audioPlayer: $audioPlayer))
                window.makeKeyAndVisible()
            }
        }
    }

    func playRingtone() {
        if let path = Bundle.main.path(forResource: "ringtone", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 // Repetir indefinidamente
                audioPlayer?.play()
            } catch {
                print("Erro ao tocar o som: \(error.localizedDescription)")
            }
        }
    }
}
