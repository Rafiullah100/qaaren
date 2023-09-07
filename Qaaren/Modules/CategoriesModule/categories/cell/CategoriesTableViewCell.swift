//
//  CategoriesTableViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/5/23.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var radioButtonView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        radioButtonView.layer.borderColor = selected ? CustomColor.uiColor(.blueishColor).cgColor : CustomColor.borderColor.color.cgColor
        radioButtonView.layer.borderWidth = selected ? 5 : 1
    }
    
}
