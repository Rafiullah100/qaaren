//
//  SelectedCategoryTableViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/8/23.
//

import UIKit

class SelectedCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var radioButtonView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        radioButtonView.layer.borderColor = selected ? CustomColor.borderColor.color.cgColor : CustomColor.uiColor(.blueishColor).cgColor
//        radioButtonView.layer.borderWidth = selected ? 1 : 5
    }
    
}
