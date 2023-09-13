//
//  UserDefaults+Extension.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/23/23.
//

import Foundation

enum AppLanguage: String {
    case arabic = "ar"
    case english = "en"
}

enum AppTheme: String {
    case dark = "dark"
    case light = "light"
}

extension UserDefaults{
    enum userdefaultsKey: String {
        case selectedLanguage
        case appTheme
    }
    
    var selectedLanguage: String?  {
        get {
            value(forKey: userdefaultsKey.selectedLanguage.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.selectedLanguage.rawValue)
        }
    }
    
    var appTheme: String?  {
        get {
            value(forKey: userdefaultsKey.appTheme.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.appTheme.rawValue)
        }
    }
}
