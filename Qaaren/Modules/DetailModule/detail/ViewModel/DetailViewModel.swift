//
//  DetailViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/31/23.
//

import Foundation
import UIKit

struct Tab {
    let title: String
    let image: String
    let selectedImage: String
}

class DetailViewModel {
    var itemsArray: [Tab] = []
    var viewControllers: [UIViewController]!
    
    
    init() {
        itemsArray = [Tab(title: "Compare", image: "Comparison", selectedImage: "Comparison-selected"), Tab(title: "About", image: "Info", selectedImage: "Info-selected"),  Tab(title: "Reviews", image: "review", selectedImage: "review-selected"),  Tab(title: "Location", image: "location", selectedImage: "location-selected"),  Tab(title: "Alerts", image: "alert", selectedImage: "alert-selected")]
        
        let compareVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompareeViewController") as! CompareeViewController
        let infoVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        let reivewVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "RevieweViewController") as! RevieweViewController
        let alertVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        let mapVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        viewControllers = [compareVC, infoVC, reivewVC, alertVC, mapVC]
    }
}
