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
        tabBarController?.tabBar.items?[Constants.selectedTabbarIndex].title = ""
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
        updateTabBarItemsTitles(selectedIndex: Constants.selectedTabbarIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            print(selectedIndex)
            updateTabBarItemsTitles(selectedIndex: selectedIndex)
        }
    }
    
    func updateTabBarItemsTitles(selectedIndex: Int) {
            guard let viewControllers = viewControllers else { return }
            for (index, viewController) in viewControllers.enumerated() {
                if let tabBarItem = viewController.tabBarItem {
                    if index == selectedIndex {
                        tabBarItem.title = ""
                    } else {
                        switch index {
                        case 0:
                            tabBarItem.title = LocalizationKeys.profile.rawValue.localizeString()
                        case 1:
                            tabBarItem.title = LocalizationKeys.category.rawValue.localizeString()
                        case 2:
                            tabBarItem.title = LocalizationKeys.home.rawValue.localizeString()
                        case 3:
                            tabBarItem.title = LocalizationKeys.settings.rawValue.localizeString()
                        case 4:
                            tabBarItem.title = LocalizationKeys.notifications.rawValue.localizeString()
                        default:
                            break
                        }
                    }
                }
            }
        }
}
