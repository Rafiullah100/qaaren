//
//  CompareTableViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/31/23.
//

import UIKit

class CompareTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nearValueLabel: NSLayoutConstraint!
    @IBOutlet weak var locationTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var nearLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var ratingStar: [UIImageView]!
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        priceLabel.text = LocalizationKeys.price.rawValue.localizeString()
        locationLabel.text = LocalizationKeys.locationType.rawValue.localizeString()
        nearLabel.text = LocalizationKeys.nearest5Km.rawValue.localizeString()
        reviewLabel.text = LocalizationKeys.reviews.rawValue.localizeString()
    }
    
    var product: Comparison? {
        didSet{
            amountLabel.text = "\(product?.price ?? "0") \(LocalizationKeys.sar.rawValue.localizeString())"
            nameLabel.text = product?.item
            locationTypeLabel.text = product?.locationType
            logoImageView.sd_setImage(with: URL(string: product?.logoURL ?? ""), placeholderImage: UIImage(named: "placeholder"))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
