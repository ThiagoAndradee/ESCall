import SwiftUI
import AVFoundation

struct VolumeButtonHandler: UIViewControllerRepresentable {
    class Coordinator: NSObject {
        var isActive: Binding<Bool>
        var volumeButtonCount = 0
        var lastButtonPressTime: TimeInterval = 0
        var audioPlayer: Binding<AVAudioPlayer?> // Para tocar o áudio personalizado
        
        init(isActive: Binding<Bool>, audioPlayer: Binding<AVAudioPlayer?>) {
            self.isActive = isActive
            self.audioPlayer = audioPlayer
        }

        @objc func volumeButtonPressed(_ notification: Notification) {
            let currentTime = Date().timeIntervalSince1970
            let elapsedTime = currentTime - lastButtonPressTime
            lastButtonPressTime = currentTime
            
            if elapsedTime < 1.0 {
                volumeButtonCount += 1
            } else {
                volumeButtonCount = 1
            }
            
            if volumeButtonCount == 3 {
                if isActive.wrappedValue {
                    triggerFakeCall()
                }
                volumeButtonCount = 0
            }
        }

        func triggerFakeCall() {
            print("Fake Call Triggered!")
            
            if let path = Bundle.main.path(forResource: "ringtone", ofType: "mp3") {
                let url = URL(fileURLWithPath: path)
                do {
                    audioPlayer.wrappedValue = try AVAudioPlayer(contentsOf: url)
                    audioPlayer.wrappedValue?.numberOfLoops = -1 // Repetir indefinidamente
                    audioPlayer.wrappedValue?.play()
                } catch {
                    print("Erro ao tocar o som: \(error.localizedDescription)")
                }
            }
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = UIHostingController(rootView: FakeCallView(audioPlayer: self.audioPlayer))
                    window.makeKeyAndVisible()
                }
            }
        }
    }

    var isActive: Binding<Bool>
    var audioPlayer: Binding<AVAudioPlayer?>
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isActive: isActive, audioPlayer: audioPlayer)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(context.coordinator.volumeButtonPressed(_:)),
            name: NSNotification.Name("AVSystemController_SystemVolumeDidChangeNotification"),
            object: nil
        )
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func dismantleUIViewController(_ uiViewController: UIViewController, coordinator: Coordinator) {
        NotificationCenter.default.removeObserver(
            coordinator,
            name: NSNotification.Name("AVSystemController_SystemVolumeDidChangeNotification"),
            object: nil
        )
    }
}
