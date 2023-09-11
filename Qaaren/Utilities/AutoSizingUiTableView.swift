//
//  AutoSizingUiTableView.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/11/23.
//

import UIKit

class AutoSizingUiTableView: UITableView {
    
    var numberOfRows: Int = 0
    var cellHeight: CGFloat = 30.0
    
    override var intrinsicContentSize: CGSize {
        let requiredHeight = CGFloat(numberOfRows) * cellHeight
        return CGSize(width: UIView.noIntrinsicMetric, height: requiredHeight)
    }
}
