//
//  ReviewViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/18/23.
//

import Foundation

class ReviewViewModel {
    var reviewList: Observable<[ReviewModel]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")

    func getReviewList(productID: Int){
        print(productID)
        URLSession.shared.request(route: .fetchReview(productID), method: .get, parameters: [:], model: [ReviewModel].self) { result in
            switch result {
            case .success(let reviews):
                self.reviewList.value = reviews
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int {
        return reviewList.value?.count ?? 0
    }
    
    func getReview(for index: Int) -> ReviewModel? {
        return reviewList.value?[index] ?? nil
    }
    
    func isFormValid(reviewInput: ReviewInoutModel) -> ValidationResponse {
        if reviewInput.review == nil || reviewInput.rating == nil {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func addReview(params: [String: Any]){
        URLSession.shared.request(route: .addReview, method: .post, parameters: params, model: [ReviewModel].self) { result in
            switch result {
            case .success(let reviews):
                self.reviewList.value = reviews
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
