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
        
        case name
        case email
        case mobile
        case profileImage
        case uuid
        case token
        case isLogin
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
    
    var name: String?  {
        get {
            value(forKey: userdefaultsKey.name.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.name.rawValue)
        }
    }
    
    var email: String?  {
        get {
            value(forKey: userdefaultsKey.email.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.email.rawValue)
        }
    }
    
    var mobile: String?  {
        get {
            value(forKey: userdefaultsKey.mobile.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.mobile.rawValue)
        }
    }
    
    var profileImage: String?  {
        get {
            value(forKey: userdefaultsKey.profileImage.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.profileImage.rawValue)
        }
    }
    
    var token: String?  {
        get {
            value(forKey: userdefaultsKey.token.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.token.rawValue)
        }
    }
    
    var uuid: String?  {
        get {
            value(forKey: userdefaultsKey.uuid.rawValue) as? String
        }
        set {
            set(newValue, forKey: userdefaultsKey.uuid.rawValue)
        }
    }
    
    var isLogin: Bool?  {
        get {
            value(forKey: userdefaultsKey.isLogin.rawValue) as? Bool
        }
        set {
            set(newValue, forKey: userdefaultsKey.isLogin.rawValue)
        }
    }
}
