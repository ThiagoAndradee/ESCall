import UIKit
import ImageIO

extension UIImage {
    public class func gif(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
                .url(forResource: name, withExtension: "gif") else {
            print("Erro ao carregar GIF: \(name)")
            return nil
        }

        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Não foi possível carregar dados de imagem")
            return nil
        }

        return gif(data: imageData)
    }

    public class func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Não foi possível criar fonte de imagem")
            return nil
        }

        return animatedImageWithSource(source)
    }

    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [UIImage]()
        var duration: TimeInterval = 0

        for i in 0..<count {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage) // Converter CGImage para UIImage
            images.append(image)

            let frameDuration = UIImage.frameDuration(at: i, source: source)
            duration += frameDuration
        }

        let animation = UIImage.animatedImage(with: images, duration: duration)
        return animation
    }

    class func frameDuration(at index: Int, source: CGImageSource) -> TimeInterval {
        var frameDuration: TimeInterval = 0.1
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        if let gifProperties = (cfProperties as NSDictionary?)?[kCGImagePropertyGIFDictionary] as? NSDictionary {
            if let delayTime = gifProperties[kCGImagePropertyGIFUnclampedDelayTime] as? Double {
                frameDuration = delayTime
            } else if let delayTime = gifProperties[kCGImagePropertyGIFDelayTime] as? Double {
                frameDuration = delayTime
            }
        }

        return frameDuration
    }
}
