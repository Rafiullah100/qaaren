//
//  AppDelegate.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/28/23.
//

import UIKit
import GoogleMaps
import Firebase
import GoogleSignIn
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        GMSServices.provideAPIKey("AIzaSyBC2Xdb2ato7ULwuGnDjPLXLAvqUZx_1VM")
        FirebaseApp.configure()

        UIView.appearance().semanticContentAttribute = UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue ? .forceRightToLeft : .forceLeftToRight
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

