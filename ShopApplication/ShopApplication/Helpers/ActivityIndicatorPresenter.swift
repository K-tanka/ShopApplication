//
//  Created by MacBook Pro on 3/11/21.
//
import UIKit

protocol ActivityIndicatorPresenter {
    var activityIndicator: UIActivityIndicatorView { get }
    
    func showActivityIndicator()
    func hideActivityIndicator()
}

extension ActivityIndicatorPresenter where Self: UIViewController {
    
    func showActivityIndicator() {
        
        DispatchQueue.main.async {
            self.activityIndicator.style = .large
            self.activityIndicator.color = .red
            self.activityIndicator.frame = CGRect(x: 150, y: 150, width: 80, height: 80)
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}
