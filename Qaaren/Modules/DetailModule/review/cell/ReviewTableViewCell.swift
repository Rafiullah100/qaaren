//
//  ReviewTableViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/1/23.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var helpfulLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        helpfulLabel.text = LocalizationKeys.helpful.rawValue.localizeString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
