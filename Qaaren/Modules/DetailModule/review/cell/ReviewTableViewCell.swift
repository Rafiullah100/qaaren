//
//  ReviewTableViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/1/23.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
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
    
    var review: ReviewModel? {
        didSet{
            nameLabel.text = review?.users?.fullName
            textView.text = review?.comment
            userImageView.sd_setImage(with: URL(string: Route.baseUrl + (review?.users?.profileImage ?? "")), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
}
