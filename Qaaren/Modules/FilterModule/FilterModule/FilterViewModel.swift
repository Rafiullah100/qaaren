//
//  FilterViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/18/23.
//

import Foundation

class FilterViewModel {
    var sourcesList: Observable<[FilterSource]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    
    func getSourcesList(){
        URLSession.shared.request(route: .allSources, method: .get, parameters: [:], model: FilterModel.self) { result in
            switch result {
            case .success(let sources):
                self.sourcesList.value = sources.sources
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int {
        return self.sourcesList.value?.count ?? 0
    }
    
    func getTitle(at index: Int) -> String{
        return self.sourcesList.value?[index].source ?? ""
    }
}
