//
//  Created by MacBook Pro on 3/11/21.
//
import UIKit

protocol SetImage: class {
    func setImage(_ image: UIImage?)
}

final class ImageCacheService {
    
    private let cacheLoader = try? CacheLoader()
    private let imageLoader = ImageLoader()
    private var images = [URL: UIImage]()
    
    func getPhoto(_ url: URL, forObjets: SetImage) {
        
        if let photo = images[url] {
            forObjets.setImage(photo)
        } else if let photo = cacheLoader?.getImageFromCache(url: url) {
            forObjets.setImage(photo)
        } else {
            imageLoader.loadPhoto(url) { [weak self] data in
                guard let image = UIImage(data: data) else {
                    assertionFailure()
                    return
                }
                self?.cacheLoader?.saveImageToCache(url: url, image: image)
                self?.images[url] = image
                forObjets.setImage(image)
            }
        }
    }
}
