//
//  Created by MacBook Pro on 3/11/21.
//
import UIKit

final class CacheLoader {
    
    private let storeURL: URL
    
    init() throws {
        do {
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                throw NSError(domain: "Problems", code: 123, userInfo: nil)
            }
            storeURL = documentDirectory.appendingPathComponent("ImageCache", isDirectory: true)
            
            if storeURL.hasDirectoryPath {
                try FileManager.default.createDirectory(at: self.storeURL, withIntermediateDirectories: true, attributes: nil)
            }
            
        } catch {
            throw NSError(domain: "Problems", code: 123, userInfo: nil)
        }
    }
    
    private func getFileUrl(url: URL) -> URL? {
        
        let lastPath = url.pathComponents.last!
        
        return storeURL.appendingPathComponent(lastPath)
    }
    
    func saveImageToCache(url: URL, image: UIImage) {
        
        guard let fileName = getFileUrl(url: url) else {
            return
        }
        
        let data = image.pngData()
        try? data?.write(to: fileName)
    }
    
    func getImageFromCache(url: URL) -> UIImage? {
        
        guard let fileName = getFileUrl(url: url) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: fileName), let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
}
