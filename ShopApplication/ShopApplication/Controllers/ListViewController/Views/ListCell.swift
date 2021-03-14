//
//  Created by MacBook Pro on 3/11/21.
//
import UIKit

struct ListCellModel {
    let id: String
    let iconURL: URL
    let name: String
    let price: String
}

final class ListCell: UICollectionViewCell, SetImage {
    
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    func configure(_ cellModel: ListCellModel) {
        nameLabel.text = cellModel.name
        priceLabel.text = cellModel.price + " $"
    }
    
    func setImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.icon.image = image
        }
    }
}
