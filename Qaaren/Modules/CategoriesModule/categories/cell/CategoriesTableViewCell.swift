//
//  CategoriesTableViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/5/23.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var radioButtonView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        radioButtonView.layer.borderColor = selected ? CustomColor.uiColor(.blueishColor).cgColor : CustomColor.borderColor.color.cgColor
//        radioButtonView.layer.borderWidth = selected ? 5 : 1
    }
    
    
    var category: AllCategory? {
        didSet{
            titleLabel.text = Helper.isRTL() == true ? category?.categoryAr : category?.category
            radioButtonView.layer.borderWidth = category?.checked == true ? 5 : 1
            radioButtonView.layer.borderColor = category?.checked == true ? CustomColor.uiColor(.blueishColor).cgColor : CustomColor.borderColor.color.cgColor
        }
    }
    
    var source: sources? {
        didSet{
            titleLabel.text = source?.source
            radioButtonView.layer.borderWidth = source?.checked == true ? 5 : 1
            radioButtonView.layer.borderColor = source?.checked == true ? CustomColor.uiColor(.blueishColor).cgColor : CustomColor.borderColor.color.cgColor
        }
    }
}
