//
//  DetailViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/31/23.
//

import Foundation

struct Tab {
    let title: String
    let image: String
    let selectedImage: String
    
}

class DetailViewModel {
    var itemsArray: [Tab] = []
    init() {
        itemsArray = [Tab(title: "Compare", image: "Comparison", selectedImage: "Comparison-selected"), Tab(title: "About", image: "Info", selectedImage: "Info-selected"),  Tab(title: "Reviews", image: "review", selectedImage: "review-selected"),  Tab(title: "Location", image: "location", selectedImage: "location-selected"),  Tab(title: "Alerts", image: "alert", selectedImage: "alert-selected")]
    }
    

}
