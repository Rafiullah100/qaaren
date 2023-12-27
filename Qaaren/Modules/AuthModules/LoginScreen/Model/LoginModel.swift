//
//  LoginModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 10/11/23.
//

import Foundation

struct LoginModel: Codable {
    let success: Bool?
    let message: String?
    let user: LoginUser?
}

// MARK: - User
struct LoginUser: Codable {
    let id: Int?
    let uuid, fullName, email, username: String?
    let password, profileImage, profileImageThumb: String?
    let contactNo, address, state, country: String?
    let locationLat, locationLng: String?
    let status: Int?
    let provider, token: String?
    let resetToken: String?
    let isActive: Bool?
    let lastLogin: String?
    let isDeleted: Int?
    let createdAt, updatedAt: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, uuid
        case fullName = "full_name"
        case email, username, password
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case contactNo = "contact_no"
        case address, state, country
        case locationLat = "location_lat"
        case locationLng = "location_lng"
        case status, provider, token
        case resetToken = "reset_token"
        case isActive
        case lastLogin = "last_login"
        case isDeleted, createdAt, updatedAt
        case userID = "userId"
    }
}



struct LoginInputModel {
    let email: String
    let password: String
}


struct ValidationResponse {
    let isValid: Bool
    let message: String
}

struct ChangePasswordModel: Codable {
    let status: Int?
    let message: String?
}

struct ChangePasswordInputModel: Codable {
    let oldPassword: String
    
    let password: String
    let confrimpassword: String
}


struct AppleLoginModel: Codable {
    let success: Bool?
    let message: String?
    let user: AppleUser?
}

// MARK: - User
struct AppleUser: Codable {
    let id: Int?
    let uuid, fullName, email, username: String?
    let password: String?
    let profileImage, profileImageThumb: String?
    let contactNo, address, state, country: String?
    let locationLat, locationLng: Double?
    let status: Int?
    let provider, token: String?
    let resetToken: String?
    let pushNotification, muteAllNotification, isActive: Bool?
    let lastLogin: String?
    let isDeleted: Int?
    let createdAt, updatedAt: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, uuid
        case fullName = "full_name"
        case email, username, password
        case profileImage = "profile_image"
        case profileImageThumb = "profile_image_thumb"
        case contactNo = "contact_no"
        case address, state, country
        case locationLat = "location_lat"
        case locationLng = "location_lng"
        case status, provider, token
        case resetToken = "reset_token"
        case pushNotification = "push_notification"
        case muteAllNotification = "mute_all_notification"
        case isActive
        case lastLogin = "last_login"
        case isDeleted, createdAt, updatedAt
        case userID = "userId"
    }
}
