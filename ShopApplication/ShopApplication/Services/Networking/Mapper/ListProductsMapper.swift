//
//  Created by MacBook Pro on 3/11/21.
//
import Foundation

final class ListProductsMapper {
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> Products {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard response.isOK, let product = try? decoder.decode(Products.self, from: data) else {
            throw NetworkError.invalidData
        }
        return product
    }
}
