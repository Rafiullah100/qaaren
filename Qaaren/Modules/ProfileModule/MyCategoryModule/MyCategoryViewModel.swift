//
//  MyCategoryViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/19/23.
//

import Foundation

class MyCategoryViewModel {
    
    var myCategories: Observable<[AllCategory]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")

    func getMyCategories(){
        URLSession.shared.request(route: .myCategories, method: .get, parameters: [:], model: AllCategoryModel.self) { result in
            switch result {
            case .success(let myCategories):
                print(myCategories)
                self.myCategories.value = myCategories.categories
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int? {
        return myCategories.value?.count
    }
    
    func getMyCategory(at index: Int) -> String? {
        return Helper.isRTL() == true ? myCategories.value?[index].categoryAr ?? nil :
        myCategories.value?[index].category ?? nil
    }
}
