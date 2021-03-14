//
//  Created by MacBook Pro on 3/11/21.
//
import Foundation

struct Products: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let productId: String
    let name: String
    let price: Int
    let image: URL
}

struct DetailProduct: Decodable {
    let productId: String
    let name: String
    let price: Int
    let image: URL
    let description: String
}


