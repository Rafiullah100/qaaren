//
//  ProductViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/7/23.
//

import Foundation

class ProductCellViewModel {
        
    var success: Observable<AlertModel> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    
    func makeFavorite(productID: Int){
        URLSession.shared.request(route: .doFavorite, method: .post, parameters: ["product_id": productID], model: AlertModel.self) { result in
            switch result {
            case .success(let success):
                self.success.value = success
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    
}
