//
//  Created by MacBook Pro on 3/11/21.
//
import UIKit

final class ListViewController: UIViewController, NibInit, ActivityIndicatorPresenter {
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        willSet {
            newValue.register(nibCell: ListCell.self)
        }
    }
    
    var dataModel: ListViewControllerDataModel?
    lazy var cacheService = ImageCacheService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        initialDataRequest()
    }
    
    private func initialDataRequest() {
        showActivityIndicator()
        dataModel?.requestInitialList()
        dataModel?.onDataSourceUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.hideActivityIndicator()
            }
            
        }
    }
}

extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataModel?.numberOfElements() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeue(cell: ListCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let cell = cell as? ListCell, let cellModel = dataModel?.createCellModel(for: indexPath.row) else {
            return
        }
        cacheService.getPhoto(cellModel.iconURL, forObjets: cell)
        cell.configure(cellModel)
    }
}

extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let selectedProduct = dataModel?.selectedProduct(at: indexPath.row) else {
            assertionFailure()
            return
        }
        
        let controller = ControllersFactory.initDetailViewControllerWith(selectedProduct.productId, cacheService: cacheService)
        controller.title = selectedProduct.name
        
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        
        return CGSize(width: itemSize, height: itemSize)
    }
}
