//
//  Created by MacBook Pro on 3/11/21.
//
import Foundation

enum URLRequestFactory {
    
    private static let baseURL = URL(string: "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart")!
    private static let baseURLForImage = URL(string: "https://s3-eu-west-1.amazonaws.com/developer-application-test/images")!
    
    static func getListURLFactory() -> URLRequest? {
        
        var request = URLRequest(url: baseURL)
        request.url?.appendPathComponent("list")
        
        return request
    }
    
    static func getDetailURLFactory(for id: String) -> URLRequest? {
        
        var request = URLRequest(url: baseURL)
        request.url?.appendPathComponent(id)
        request.url?.appendPathComponent("detail")
        
        return request
    }
//    
//    static func getImageURLFactory(for id: String) -> URLRequest? {
//        
//        var request = URLRequest(url: baseURLForImage)
//        request.url?.appendPathComponent("\(id).jpg")
//
//        return request
//    }
}

enum NetworkError: Error {
    
    case unexpectedDataRepresenation
    case urlCreationError
    case invalidData
}
