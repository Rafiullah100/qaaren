//
//  CompareTableViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/31/23.
//

import UIKit

class CompareTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var nearLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        priceLabel.text = LocalizationKeys.price.rawValue.localizeString()
        amountLabel.text = "1180 \(LocalizationKeys.sar.rawValue.localizeString())"
        locationLabel.text = LocalizationKeys.locationType.rawValue.localizeString()
        nearLabel.text = LocalizationKeys.nearest5Km.rawValue.localizeString()
        reviewLabel.text = LocalizationKeys.reviews.rawValue.localizeString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
