//
//  AllCategoryViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/18/23.
//

import Foundation

class AllCategoryViewModel {

    var categories: Observable<[AllCategory]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    var sources: Observable<[sources]> = Observable(nil)
    var success: Observable<SuccessModel> = Observable(nil)

    
    func getAllCategories(){
        URLSession.shared.request(route: .allCategory, method: .get, parameters: [:], model: AllCategoryModel.self) { result in
            switch result {
            case .success(let allCategories):
                print(allCategories)
                self.categories.value = allCategories.categories
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int {
        return categories.value?.count ?? 0
    }
    
    func getCategory(for index: Int) -> AllCategory? {
        return categories.value?[index] ?? nil
    }
    
    
    func getAllSources(){
        URLSession.shared.request(route: .allSources, method: .get, parameters: [:], model: AllSourcesModel.self) { result in
            switch result {
            case .success(let allSources):
                self.sources.value = allSources.sources
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getSourcesCount() -> Int {
        return sources.value?.count ?? 0
    }
    
    func getSources(for index: Int) -> sources? {
        return sources.value?[index] ?? nil
    }
    
    func addCategory(categoryId: Int){
        URLSession.shared.request(route: .addCatgory, method: .post, parameters: ["categoryId": categoryId], model: SuccessModel.self) { result in
            switch result {
            case .success(let success):
                self.success.value = success
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func addSource(sourceID: Int){
        URLSession.shared.request(route: .addSource, method: .post, parameters: ["sourceId": sourceID], model: SuccessModel.self) { result in
            switch result {
            case .success(let success):
                self.success.value = success
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCategoryCheck(for index: Int) -> Bool? {
        return categories.value?[index].checked
    }
    
    func ChangeCategoyStatus(for index: Int){
        let status = categories.value?[index].checked
        guard let status = status else { return }
        categories.value?[index].checked = !status
    }

    func getCatID(for index: Int) -> Int? {
        return categories.value?[index].id ?? 0
    }
    
    
    /////////dmretmrotnhrothnoth5nht
    func getSourceCheck(for index: Int) -> Bool? {
        return sources.value?[index].checked
    }
    
    func ChangeSourceStatus(for index: Int){
        let status = sources.value?[index].checked
        guard let status = status else { return }
        sources.value?[index].checked = !status
    }

    func getSourceID(for index: Int) -> Int? {
        return sources.value?[index].id ?? 0
    }
}
