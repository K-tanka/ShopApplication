//
//  Created by MacBook Pro on 3/11/21.
//
import Foundation

final class GetProductDetailService {

    typealias DetailResult = Swift.Result<DetailProduct, Error>

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getProductDetail(request: URLRequest, completion: @escaping (DetailResult) -> Void) {

        session.dataTask(with: request) { data, response, error in

            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return try ProductDetailMapper.map(data, from: response)
                } else {
                    throw NetworkError.unexpectedDataRepresenation
                }
            })
        }.resume()
    }
}
