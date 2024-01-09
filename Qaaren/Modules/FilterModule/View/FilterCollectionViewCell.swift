//
//  FilterCollectionViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 1/9/24.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet var ratingStar: [UIImageView]!
    @IBOutlet weak var totalReviewLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var product: FilterCatalogue?{
        didSet{
//            favoriteIcon.image = UIImage(named: product?.isWishlist == 1 ? "favorite_red" : "favorite_gray")
            thumbnail.sd_setImage(with: URL(string: product?.images?.first ?? ""), placeholderImage: UIImage(named: "placeholder"))
            nameLabel.text = product?.title
//            totalReviewLabel.text = "(\(product?.totalReviews ?? 0))"
            watchLabel.text = "\(product?.watchCount ?? 0) \(LocalizationKeys.watching.rawValue.localizeString())"
            amountLabel.text = "\(product?.minPrice ?? "0")-\(product?.maxPrice ?? "0") \(LocalizationKeys.sar.rawValue.localizeString())"
//            for (index, starImageView) in ratingStar.enumerated() {
//                let rating = product?.totalRating ?? 0
//                let imageName = index < rating ? "star" : "star-unfill"
//                starImageView.image = UIImage(named: imageName)
//            }
        }
    }
}
