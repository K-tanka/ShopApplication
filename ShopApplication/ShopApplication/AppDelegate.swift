//
//  Created by MacBook Pro on 3/11/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = ControllersFactory.initListViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

enum ControllersFactory {

    static func initListViewController() -> ListViewController  {
        
        let networkService = GetListProductsService()
        let dataModel = ListViewControllerDataModelImpl(networkService: networkService)
        let controller = ListViewController.initFromNib()
        controller.dataModel = dataModel
        return controller
    }

    static func initDetailViewControllerWith(_ id: String, cacheService: ImageCacheService) -> DetailViewController  {
        
        let networkService = GetProductDetailService()
        let cacheService = ImageCacheService()
        let controller = DetailViewController()
        let dataModel = DetailViewControllerDataModelImpl(networkService: networkService, productId: id, cacheService: cacheService, controller: controller)
        controller.dataModel = dataModel
        return controller
    }
}
