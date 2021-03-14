//
//  Created by MacBook Pro on 3/11/21.
//
import UIKit

protocol ListViewControllerDataModel {

    var onDataSourceUpdated: (() -> Void)? { get set }

    func numberOfElements() -> Int
    func requestInitialList()
    func selectedProduct(at index: Int) -> Product
    func createCellModel(for index: Int) -> ListCellModel
}

final class ListViewControllerDataModelImpl: ListViewControllerDataModel {

    private let networkService: GetListProductsService
    private var listProducts = [Product]()

    var onDataSourceUpdated: (() -> Void)?

    init(networkService: GetListProductsService) {
        self.networkService = networkService
    }

    func requestInitialList() {

        guard let request = URLRequestFactory.getListURLFactory() else {
            assertionFailure()
            return
        }

        networkService.getListProducts(request: request) { [weak self] items in
            switch items {
            case .success(let product):
                self?.listProducts.append(contentsOf: product.products)
                self?.onDataSourceUpdated?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func numberOfElements() -> Int {
        listProducts.count
    }

    func selectedProduct(at index: Int) -> Product {
        return listProducts[index]
    }

    func createCellModel(for index: Int) -> ListCellModel {

        let item = listProducts[index]

        return ListCellModel(id: item.productId,
                             iconURL: item.image,
                             name: item.name,
                             price: "\(item.price)")
    }
}

