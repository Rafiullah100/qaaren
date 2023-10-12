//
//  ProductCollectionViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/29/23.
//

import UIKit

enum CardType {
    case home
    case favorite
}

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    var type: CardType?{
        didSet{
            favoriteIcon.image = type == .home ? UIImage(named: "favorite_gray") : UIImage(named: "favorite_red")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        priceLabel.text = LocalizationKeys.price.rawValue.localizeString()
        amountLabel.text = "590-882 \(LocalizationKeys.sar.rawValue.localizeString())"
    }
}
