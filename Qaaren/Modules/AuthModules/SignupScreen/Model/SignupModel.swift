//
//  SignupModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 10/11/23.
//

import Foundation

struct SignupModel: Codable {
    let success: Bool?
    let message: String?
}

struct SignupInputModel {
    let name: String
    let email: String
    let password: String
    let confirm: String
    
}
