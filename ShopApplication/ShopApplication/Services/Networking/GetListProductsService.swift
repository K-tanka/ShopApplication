//
//  Created by MacBook Pro on 3/11/21.
//
import Foundation

final class GetListProductsService {

    typealias ProductsResult = Swift.Result<Products, Error>

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getListProducts(request: URLRequest, completion: @escaping (ProductsResult) -> Void) {

        session.dataTask(with: request) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return try ListProductsMapper.map(data, from: response)
                } else {
                    throw NetworkError.unexpectedDataRepresenation
                }
            })
        }.resume()
    }
}
