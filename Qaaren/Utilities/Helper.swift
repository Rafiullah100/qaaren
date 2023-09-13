//
//  Helper.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//

import Foundation
import UIKit
open class Helper{
    static let shared = Helper()
    
    
    static func cellSize(noOfCells: Int, space: Int, collectionView: UICollectionView)-> CGSize{
        let cellsAcross: CGFloat = CGFloat(noOfCells)
        let spaceBetweenCells: CGFloat = CGFloat(space)
        var width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells)
        width = (width - 155) / cellsAcross
        print(width)
        return CGSize(width: width, height: 45)
    }
    
    static func attributedText(text1: String, text2: String)-> NSMutableAttributedString{
        let text1Attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Constants.fontNameMedium, size: 19) ?? UIFont(),
            .foregroundColor: UIColor.label
        ]

        let text2Attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Constants.fontNameMedium, size: 15) ?? UIFont(),
            .foregroundColor: UIColor.label
        ]

        let attributedString1 = NSAttributedString(string: text1, attributes: text1Attributes)
        let attributedString2 = NSAttributedString(string: text2, attributes: text2Attributes)

        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(attributedString1)
        combinedAttributedString.append(attributedString2)
        return combinedAttributedString
    }
}


