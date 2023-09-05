//
//  LanguageManager.swift
//  News Hunt
//
//  Created by MacBook Pro on 8/23/23.
//

import Foundation
import UIKit

enum AppLanguage: String, CaseIterable {
    case english = "English"
    case urdu = "Urdu"
    case persian = "Persian"
    case french = "French"
    case arabic = "Arabic"
    
    var isLTR: Bool {
        return self == .english || self == .french
    }
}

class LanguageManager {
    static let shared = LanguageManager()
    private init() {}

    var selectedLanguage: AppLanguage {
          get {
              if let rawValue = UserDefaults.standard.string(forKey: UserDefaults.userdefaultsKey.selectedLanguage.rawValue),
                 let language = AppLanguage(rawValue: rawValue) {
                  changeDirection(language: UserDefaults.userdefaultsKey.selectedLanguage.rawValue)
                  return language
              } else {
                  changeDirection(language: UserDefaults.userdefaultsKey.selectedLanguage.rawValue)
                  return .english
              }
          }
          set {
              UserDefaults.standard.set(newValue.rawValue, forKey: UserDefaults.userdefaultsKey.selectedLanguage.rawValue)
              changeDirection(language: UserDefaults.userdefaultsKey.selectedLanguage.rawValue)
          }
      }

    func getLanguage() -> AppLanguage {
        if let language = UserDefaults.standard.selectedLanguage{
            selectedLanguage = language
            return language
        }
        else{
            selectedLanguage = .english
            return .english
        }
    }
    
    func changeDirection(language: String) {
        print(language)
        guard let language = AppLanguage(rawValue: language) else { return }
        if language.isLTR {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        else{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
    }
}
