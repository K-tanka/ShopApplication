//
//  Created by MacBook Pro on 3/11/21.
//
import Foundation

final class ImageLoader {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .ephemeral)) {
        self.session = session
    }
    
    func loadPhoto(_ url: URL, completion: @escaping (Data) -> Void) {
        
        session.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, response.isOK else {
                return
            }
            completion(data)
        }.resume()
    }    
}
