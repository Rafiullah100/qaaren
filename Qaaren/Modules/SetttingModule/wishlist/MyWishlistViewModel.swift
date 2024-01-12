//
//  MyWishlistViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/19/23.
//

import Foundation

class MyWishlistViewModel {

    var myWishlist: Observable<[Wishlist]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")

    func getWishlist(){
        URLSession.shared.request(route: .myWishlist, method: .get, parameters: [:], model: MyWishlistModel.self) { result in
            switch result {
            case .success(let myWishlist):
                self.myWishlist.value = myWishlist.wishlist
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCount() -> Int? {
        return self.myWishlist.value?.count
    }
    
    func getSingleCategory(at index: Int) -> Wishlist? {
        return self.myWishlist.value?[index]
    }
    
    func getTitle(at index: Int) -> String {
        return self.myWishlist.value?[index].category ?? ""
    }

}
