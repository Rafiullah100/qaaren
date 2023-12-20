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

protocol DataPassingDelegate: AnyObject {
    func comparisonItemsData(_ itemList: [Comparison])
}

class DetailViewModel {
    var itemsArray: [Tab] = []
    var viewControllers: [UIViewController]!
    
    var productDetail: Observable<DetailModel> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    
    var delegate: DataPassingDelegate?
    
    init() {
        itemsArray = [Tab(title: LocalizationKeys.compare.rawValue.localizeString(), image: "Comparison", selectedImage: "Comparison-selected"), Tab(title: LocalizationKeys.about.rawValue.localizeString(), image: "Info", selectedImage: "Info-selected"),  Tab(title: LocalizationKeys.reviews.rawValue.localizeString(), image: "review", selectedImage: "review-selected"),  Tab(title: LocalizationKeys.location.rawValue.localizeString(), image: "location", selectedImage: "location-selected"),  Tab(title: LocalizationKeys.alerts.rawValue.localizeString(), image: "alert", selectedImage: "alert-selected")]
        
        let compareVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "CompareeViewController") as! CompareeViewController
        let infoVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        let reivewVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "RevieweViewController") as! RevieweViewController
        let alertVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AlertViewController") as! AlertViewController
        let mapVC = UIStoryboard(name: Storyboard.detail.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        viewControllers = [compareVC, infoVC, reivewVC, alertVC, mapVC]
    }
    
    func getDetail(productID: Int){
        print(productID)
        URLSession.shared.request(route: .detailApi(productID), method: .get, parameters: [:], model: DetailModel.self) { result in
            switch result {
            case .success(let detail):
                print(detail)
                self.productDetail.value = detail
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getTitle() -> String {
        return self.productDetail.value?.itemDetail?.title ?? ""
    }
    
    func getRating() -> Int {
        return self.productDetail.value?.itemDetail?.totalReviewsCount?.first?.totalReviewsCount ?? 0
    }
    
    func getImages(_ index: Int) -> String {
        let array = self.productDetail.value?.itemDetail?.images
        guard array?.indices.contains(index) == true else { return "" }
        return array?[index] ?? ""
    }
    
    func getImageCount() -> Int {
        return self.productDetail.value?.itemDetail?.images?.count ?? 0
    }
    
    func getComparisonItems() -> [Comparison] {
        return self.productDetail.value?.comparisons ?? []
    }
    
    func getDescription() -> String {
        return self.productDetail.value.debugDescription
    }

}
