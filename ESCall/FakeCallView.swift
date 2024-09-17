import SwiftUI
import AVFoundation

struct FakeCallView: View {
    @Binding var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Incoming Call")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Spacer()
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)

                Text("Caller Name")
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()

                HStack(spacing: 50) {
                    Button(action: {
                        rejectCall()
                    }) {
                        Image(systemName: "phone.down.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        answerCall()
                    }) {
                        Image(systemName: "phone.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.green)
                    }
                }
                .padding(.bottom, 50)
            }
        }
    }
    
    func rejectCall() {
        audioPlayer?.stop() // Parar o ringtone
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = UIHostingController(rootView: HomeView())
            window.makeKeyAndVisible()
        }
    }
    
    func answerCall() {
        audioPlayer?.stop() // Parar o ringtone
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = UIHostingController(rootView: CallInProgressView())
            window.makeKeyAndVisible()
        }
    }
}
