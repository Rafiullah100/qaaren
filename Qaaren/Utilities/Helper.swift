//
//  Helper.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/1/23.
//

import Foundation
import UIKit
open class Helper{
    
    
    class func cellSize(noOfCells: Int, space: Int, collectionView: UICollectionView)-> CGSize{
        let cellsAcross: CGFloat = CGFloat(noOfCells)
        let spaceBetweenCells: CGFloat = CGFloat(space)
        var width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells)
        width = (width - 155) / cellsAcross
        print(width)
        return CGSize(width: width, height: 45)
    }
    
    class func attributedText(text1: String, text2: String)-> NSMutableAttributedString{
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
    
    class func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
   class func isRTL() -> Bool{
        return UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue ? true : false
    }
    
    class func isLogin() -> Bool {
        guard let login = UserDefaults.standard.isLogin else { return false }
        return login
    }

}


