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
                viewController.tabBarItem.title = "Profile"
            }
            else if index == 1 {
                viewController.tabBarItem.title = "Categories"
            }
            else if index == 2 {
                viewController.tabBarItem.title = "Home"
            }
            else if index == 3 {
                viewController.tabBarItem.title = "Settings"
            }
            else if index == 4 {
                viewController.tabBarItem.title = "Notifications"
            }
        }
    }
}
