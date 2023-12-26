//
//  Route.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 30/04/2021.
//

import Foundation

enum Route {
    static let baseUrl = "https://admin.qaaren.com/"
    case signup
    case login
    case weatherApi
    case categoryList
    case subCategoryList(Int)
    case detailApi(Int)
    case fetchReview(Int)
    case addReview
    case allSources
    case allCategory
    case addCatgory
    case addSource
    case myCategories
    case mySources
    case myWishlist
    case myProfile
    case doFavorite
    case viewAll(Int)
    case changePassword
    case priceAlert
    case googleSignin
    case updateProfile
    case watch(Int)
    case search(String)
    
    var description: String {
        switch self {
        case .signup:
            return "mobile/auth/registers"
        case .login:
            return "mobile/auth/logincustomer"
        case .weatherApi:
            return "api/mobile/api/mobile/districts/list"
        case .categoryList:
            return "mobile/category/get-categories"
        case .subCategoryList(let id):
            return "mobile/home/categorylist/\(id)"
        case .detailApi(let id):
            return "mobile/items/get-items/item/\(id)/detail"
        case .fetchReview(let id):
            return "mobile/review/get-review/item/\(id)/get"
        case .addReview:
            return "mobile/review/create-review"
        case .allSources:
            return "mobile/interests/get-all-sources"
        case .allCategory:
            return "mobile/interests/get-all-category"
        case .addCatgory:
            return "mobile/interests/add-category"
        case .addSource:
            return "mobile/interests/add-source"
        case .myCategories:
            return "mobile/interests/get-selected-category"
        case .mySources:
            return "mobile/interests/get-selected-sources"
        case .myWishlist:
            return "mobile/wistlist/wish-list"
        case .myProfile:
            return "mobile/users/profile"
        case .doFavorite:
            return  "mobile/wistlist/do_wish"
        case .viewAll(let id):
            return "mobile/items/get-items/sub-category/\(id))/get"
        case .changePassword:
            return "mobile/users/password/update"
        case .priceAlert:
            return "mobile/price-alerts/create"
        case .googleSignin:
            return "mobile/auth/google-login"
        case .updateProfile:
            return "mobile/users/profile/update"
        case .watch(let id):
            return "mobile/items/get-items/item/\(id)/watch_count"
        case .search(let q):
            return "mobile/search/text?q=\(q)"
        } 
    }
}
