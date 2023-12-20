//
//  ProfileModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/19/23.
//

import Foundation

struct ProfileModel: Codable {
    let status: Int?
    let customer: Customer?
    let message: String?
}

// MARK: - Customer
struct Customer: Codable {
    let id: Int?
    let uuid, fullName, email, username: String?
    let password, profileImage, profileImageThumb, contactNo: String?
    let address, state, country: String?
    let locationLat, locationLng: String?
    let status: Int?
    let provider, token: String?
    let resetToken: String?
    let pushNotification, muteAllNotification: Bool?
    let isActive: Int?
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
