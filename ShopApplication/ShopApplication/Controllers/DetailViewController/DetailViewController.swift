//
//  Created by MacBook Pro on 3/11/21.
//
import UIKit

struct ViewModel {
    let iconURL: URL
    let price: String
    let description: String
}

final class DetailViewController: UIViewController, ActivityIndicatorPresenter, AlertControllerPresenter,SetImage {
    
    var activityIndicator = UIActivityIndicatorView()
    var alertController = UIAlertController()
    
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var dataModel: DetailViewControllerDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDataRequest()
    }
    
    private func initialDataRequest() {
        
        showActivityIndicator()
        dataModel?.requestInitialDetail()
        
        dataModel?.onDataSourceUpdated = { [weak self] error in
            
            if error != nil {
                self?.hideActivityIndicator()
                self?.showAlertController()
            } else {
                DispatchQueue.main.async {
                    self?.configureView()
                    self?.hideActivityIndicator()
                }
            }
        }
    }
    
    private func configureView() {
        guard let viewModel = dataModel?.configureView() else {
            assertionFailure()
            return
        }
        
        priceLabel.text = viewModel.price + " $"
        descriptionLabel.text = viewModel.description
        
    }
    
    func setImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.icon.image = image
        }
    }
}
