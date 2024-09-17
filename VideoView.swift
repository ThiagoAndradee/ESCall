import SwiftUI
import AVKit

struct VideoView: UIViewControllerRepresentable {
    let videoName: String

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        
        if let path = Bundle.main.path(forResource: videoName, ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            let player = AVPlayer(url: url)
            controller.player = player
            controller.showsPlaybackControls = false // Desativar os controles de reprodução
            controller.player?.play() // Iniciar o vídeo automaticamente
            controller.player?.isMuted = true // Remover o som, caso não seja necessário
        }
        
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Não há necessidade de atualizar a view no momento
    }
}
