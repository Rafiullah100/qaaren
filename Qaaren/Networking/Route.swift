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
   
    
    var description: String {
        switch self {
        case .signup:
            return "mobile/auth/registers"
        case .login:
            return "mobile/auth/logincustomer"
        case .weatherApi:
            return "api/mobile/api/mobile/districts/list"
        } 
    }
}
