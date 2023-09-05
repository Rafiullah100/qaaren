//
//  UserDefaults+Extension.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/23/23.
//

import Foundation

extension UserDefaults{
    enum userdefaultsKey: String {
        case selectedLanguage
    }
    
    var selectedLanguage: String?  {
        get {
            value(forKey: userdefaultsKey.selectedLanguage.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.selectedLanguage.rawValue)
        }
    }
}
