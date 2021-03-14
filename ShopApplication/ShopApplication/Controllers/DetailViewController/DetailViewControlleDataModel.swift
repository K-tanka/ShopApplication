//
//  Created by MacBook Pro on 3/11/21.
//
import UIKit

protocol DetailViewControllerDataModel {
    
    var onDataSourceUpdated: ((Error?) -> Void)? { get set }
    var cacheService: ImageCacheService { get }
    
    func requestInitialDetail()
    func configureView() -> ViewModel?
}

final class DetailViewControllerDataModelImpl: DetailViewControllerDataModel {

    private let networkService: GetProductDetailService
    private var product: DetailProduct?
    private var productId: String
    internal let cacheService: ImageCacheService
    weak var controller: SetImage?

    var onDataSourceUpdated: ((Error?) -> Void)?

    init(networkService: GetProductDetailService, productId: String, cacheService: ImageCacheService, controller: SetImage) {
        self.networkService = networkService
        self.productId = productId
        self.cacheService = cacheService
        self.controller = controller
    }
    
    func requestInitialDetail() {

        guard let request = URLRequestFactory.getDetailURLFactory(for: productId) else {
            assertionFailure()
            return
        }
        
        networkService.getProductDetail(request: request) { [weak self] items in
            switch items {
            case .success(let product):
                self?.product = product
                self?.cacheService.getPhoto(product.image, forObjets: self?.controller as! SetImage )
                self?.onDataSourceUpdated?(nil)
            case .failure(let error):
                self?.onDataSourceUpdated?(error)
            }
        }
        
        
    }
    
    func configureView() -> ViewModel? {
        
        guard let item = product else {
            return nil
        }
        return ViewModel(iconURL: item.image,
                         price: "\(item.price)",
                         description: item.description)
    }
}
