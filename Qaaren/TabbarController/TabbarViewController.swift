//
//  TabbarViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/28/23.
//

import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tabBarController?.tabBar.items?[2].title = ""
//        
//        if let tabBar = self.tabBarController?.tabBar {
//            let normalTextAttributes: [NSAttributedString.Key: Any] = [
//                .foregroundColor: UIColor.white,
//                .font: Constants.fontNameMedium
//            ]
//            
//            tabBar.items?.forEach { item in
//                item.setTitleTextAttributes(normalTextAttributes, for: .normal)
////                tabBar.items?[4].title = LocalizationKeys.notifications.rawValue.localizeString()
////                tabBar.items?[3].title = LocalizationKeys.settings.rawValue.localizeString()
////                tabBar.items?[2].title = LocalizationKeys.home.rawValue.localizeString()
////                tabBar.items?[1].title = LocalizationKeys.category.rawValue.localizeString()
////                tabBar.items?[0].title = LocalizationKeys.profile.rawValue.localizeString()
//            }
//            
//        }
        updateTabBarItemsTitles(selectedIndex: 2)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            updateTabBarItemsTitles(selectedIndex: selectedIndex)
        }
    }
    
    func updateTabBarItemsTitles(selectedIndex: Int) {
        for (index, viewController) in viewControllers?.enumerated() ?? [].enumerated() {
            if index == selectedIndex {
                viewController.tabBarItem.title = ""
            } else if index == 0 {
                viewController.tabBarItem.title = LocalizationKeys.profile.rawValue.localizeString()
            }
            else if index == 1 {
                viewController.tabBarItem.title = LocalizationKeys.category.rawValue.localizeString()
            }
            else if index == 2 {
                viewController.tabBarItem.title = LocalizationKeys.home.rawValue.localizeString()
            }
            else if index == 3 {
                viewController.tabBarItem.title = LocalizationKeys.settings.rawValue.localizeString()
            }
            else if index == 4 {
                viewController.tabBarItem.title = LocalizationKeys.notifications.rawValue.localizeString()
            }
        }
    }
}
