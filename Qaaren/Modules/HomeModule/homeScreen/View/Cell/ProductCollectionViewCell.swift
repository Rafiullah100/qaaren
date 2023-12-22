//
//  ProductCollectionViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/29/23.
//

import UIKit
import SDWebImage
enum CardType {
    case home
    case favorite
}

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet var ratingStar: [UIImageView]!
    @IBOutlet weak var totalReviewLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
   
    var didTappedFavorite: (() -> Void)? = nil

    
//    var type: CardType?{
//        didSet{
//            favoriteIcon.image = type == .home ? UIImage(named: "favorite_gray") : UIImage(named: "favorite_red")
//        }
//    }
    
    var product: Catalogue?{
        didSet{
            favoriteIcon.image = UIImage(named: product?.isWishlist == 1 ? "favorite_red" : "favorite_gray")
            thumbnail.sd_setImage(with: URL(string: product?.items?.first?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            nameLabel.text = product?.title
            totalReviewLabel.text = "(\(product?.totalReviews ?? 0))"
            watchLabel.text = "\(product?.watchCount ?? 0)"
            amountLabel.text = "\(product?.minPrice ?? "")-\(product?.maxPrice ?? "") \(LocalizationKeys.sar.rawValue.localizeString())"
            for (index, starImageView) in ratingStar.enumerated() {
                guard let rating = Double(product?.totalRating ?? "0") else { return }
                let imageName = index < Int(round(rating)) ? "star" : "star-unfill"
                starImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    var wishlistProduct: Product?{
        didSet{
            favoriteIcon.image = UIImage(named: "favorite_red")
            thumbnail.sd_setImage(with: URL(string: wishlistProduct?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            nameLabel.text = wishlistProduct?.catalogues?.title
            totalReviewLabel.text = "(\(wishlistProduct?.catalogues?.totalReviews ?? 0))"
            amountLabel.text = "\(wishlistProduct?.minPrice ?? 0)-\(wishlistProduct?.maxPrice ?? 0) \(LocalizationKeys.sar.rawValue.localizeString())"
            watchLabel.text = "\(wishlistProduct?.catalogues?.watchCount ?? 0)"
            for (index, starImageView) in ratingStar.enumerated() {
                guard let rating = Double(wishlistProduct?.catalogues?.totalRating ?? "0") else { return }
                let imageName = index < Int(round(rating)) ? "star" : "star-unfill"
                starImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    var viewAllProduct: ViewallItem?{
        didSet{
            thumbnail.sd_setImage(with: URL(string: viewAllProduct?.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
            nameLabel.text = viewAllProduct?.catalogue
            totalReviewLabel.text = "(\(viewAllProduct?.totalReviews ?? 0))"
            amountLabel.text = "\(viewAllProduct?.price ?? "") \(LocalizationKeys.sar.rawValue.localizeString())"
            watchLabel.text = "\(viewAllProduct?.sourceCount ?? 0)"
            for (index, starImageView) in ratingStar.enumerated() {
                guard let rating = Double(viewAllProduct?.totalRating ?? "0") else { return }
                let imageName = index < Int(round(rating)) ? "star" : "star-unfill"
                starImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        priceLabel.text = LocalizationKeys.price.rawValue.localizeString()
    }
    
    @IBAction func favoriteBtnAction(_ sender: Any) {
        didTappedFavorite?()
    }
}
