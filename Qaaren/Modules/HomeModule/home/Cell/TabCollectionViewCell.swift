//
//  TabCollectionViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/29/23.
//

import UIKit

enum TabType {
    case category
    case detail
}

class TabCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
