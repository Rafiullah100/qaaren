//
//  FilterViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/18/23.
//

import Foundation

class FilterViewModel {
    var sourcesList: Observable<[FilterSourceData]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    var filteredData: Observable<[FilterCatalogue]> = Observable(nil)

    func getSourcesList(){
        URLSession.shared.request(route: .allSources, method: .get, parameters: [:], model: FilterSourcesModel.self) { result in
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
    
    func getSourceId(for index: Int) -> Int {
        return self.sourcesList.value?[index].id ?? 0
    }
    
    func getFilteredData(from max: Int, to min: Int, for sourceId: Int) {
        
        URLSession.shared.request(route: .filter, method: .get, parameters: ["maxPrice": max, "source_id": sourceId, "minPirce": min], model: [FilterModel].self) { result in
            switch result {
            case .success(let filter):
                self.filteredData.value = filter.first?.catalogue
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getFilterCount() -> Int {
        return self.filteredData.value?.count ?? 0
    }
    
    func getFilterProduct(for index: Int) -> FilterCatalogue? {
        return self.filteredData.value?[index]
    }
    
    func getProductID(for index: Int) -> Int? {
        return self.filteredData.value?[index].catalogueID
    }
}
