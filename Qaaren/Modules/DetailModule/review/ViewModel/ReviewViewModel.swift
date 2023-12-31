//
//  ReviewViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/18/23.
//

import Foundation

protocol AddReviewProtocol {
    func reviewAdded(review: AddReviewModel)
}

class ReviewViewModel {
    var reviewList: Observable<[ReviewModelData]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    var addedReview: Observable<AddReviewModel> = Observable(nil)
    var parameters: [String: Any]?
    var reviewData: ReviewModel?
    
    func getReviewList(productID: Int){
        print(productID)
        URLSession.shared.request(route: .fetchReview(productID), method: .get, parameters: [:], model: ReviewModel.self) { result in
            switch result {
            case .success(let reviews):
                self.reviewData = reviews
                self.reviewList.value = reviews.reviewData
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int {
        return reviewList.value?.count ?? 0
    }
    
    func getReview(for index: Int) -> ReviewModelData? {
        return reviewList.value?[index] ?? nil
    }
    
    func isFormValid(reviewInput: ReviewInoutModel) -> ValidationResponse {
        if reviewInput.review == nil || reviewInput.rating == nil || reviewInput.review ==  LocalizationKeys.addReview.rawValue.localizeString() {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            parameters = ["catalogue_id": reviewInput.id!, "rating": reviewInput.rating!, "comment": reviewInput.review!]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func addReview(){
        URLSession.shared.request(route: .addReview, method: .post, parameters: parameters, model: AddReviewModel.self) { result in
            switch result {
            case .success(let review):
                print(review)
                //                self.reviewData = review
                self.addedReview.value = review
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
            //        }
        }
    }
    
    func getReviewStar(for key: String) -> Int {
        return self.reviewData?.ratingCount?[key] ?? 0
    }
    
//    func getRatingValue(rating: Int) -> Int {
//        <#function body#>
//    }
}
