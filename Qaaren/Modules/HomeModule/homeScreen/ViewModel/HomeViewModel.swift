//
//  HomeViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 8/29/23.
//

import Foundation

class HomeViewModel {
       
//    var bindCategoryResultToView: (() -> Void) = { }
//    var bindSubCategoryResultToView: (() -> Void) = { }

    var categories: Observable<[CategoryModel]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    var subCategories: Observable<[SubCategoryModel]> = Observable(nil)
    
    init() {
        self.getCategories()
    }

    func getCategories(){
        URLSession.shared.request(route: .categoryList, method: .get, parameters: [:], model: [CategoryModel].self) { result in
            switch result {
            case .success(let categories):
                self.categories.value = categories
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getSubCategories(categoryID: Int){
        URLSession.shared.request(route: .subCategoryList(categoryID), method: .get, parameters: [:], model: [SubCategoryModel].self) { result in
            switch result {
            case .success(let subCategories):
                self.subCategories.value = subCategories.filter( { !($0.catalogue?.isEmpty ?? true) })
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    
    func getCategoriesCount() -> Int {
        return self.categories.value?.count ?? 0
    }
    
    func getSubCategoriesCount() -> Int {
        return self.subCategories.value?.count ?? 0
    }
    
    func getCategoryID(_ index: Int) -> Int {
        return self.categories.value?[index].id ?? 0
    }
    
    func categoryTitle(at index: Int) -> String {
        return self.categories.value?[index].category ?? ""
    }
    
    func getSubCategory(atIndex index: Int) -> SubCategoryModel? {
        return subCategories.value?[index]
    }
    
    func getSubCategoryID(at index: Int) -> Int {
        return subCategories.value?[index].id ?? 0
    }
}
