//
//  Created by MacBook Pro on 3/11/21.
//
import UIKit

protocol AlertControllerPresenter {
    
    var alertController: UIAlertController { get }
    
    func showAlertController()
}

extension AlertControllerPresenter where Self: UIViewController {
    
    func showAlertController() {
        
        DispatchQueue.main.async {
            
            let alertController: UIAlertController = {
                let alertController = UIAlertController(title: "Error", message: "Unknown error occurred", preferredStyle: .alert)
                
                return alertController
            }()
            
            let cancelAction: UIAlertAction = {
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                return cancelAction
            }()
            
            alertController.addAction(cancelAction)
            

            self.present(alertController, animated: true, completion: nil)
        }
    }
}
