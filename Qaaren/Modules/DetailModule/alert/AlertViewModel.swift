//
//  AlertViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/20/23.
//

import Foundation

enum EventType: String {
    case rise
    case drop
}

class AlertViewModel {
    let evenTypes: [EventType] = [.rise, .drop]
    
    var errorMessage: Observable<String> = Observable("")
    var alert: Observable<AlertModel> = Observable(nil)

    
    
    func callAlert(eventType: String, productID: Int){
        URLSession.shared.request(route: .priceAlert, method: .post, parameters: ["product_id": productID, "event": eventType], model: AlertModel.self) { result in
            switch result {
            case .success(let alert):
                self.alert.value = alert
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }

    
    
    func eventType() -> [EventType] {
        return  evenTypes
    }
    
    func getTitle(at index: Int) -> String {
        return evenTypes[index].rawValue
    }
}
