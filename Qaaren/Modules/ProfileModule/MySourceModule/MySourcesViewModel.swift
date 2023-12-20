//
//  MySourcesViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/19/23.
//

import Foundation

class MySourcesViewModel {
    
    var mySources: Observable<[sources]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")

    func getMyCategories(){
        URLSession.shared.request(route: .mySources, method: .get, parameters: [:], model: AllSourcesModel.self) { result in
            switch result {
            case .success(let mySources):
                print(mySources)
                self.mySources.value = mySources.sources
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int {
        return mySources.value?.count ?? 0
    }
    
    func getMySource(at index: Int) -> String? {
        return mySources.value?[index].source ?? nil
    }
}
