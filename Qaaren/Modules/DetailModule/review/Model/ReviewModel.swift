//
//  ReviewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/18/23.
//

import Foundation



struct ReviewModel: Codable {
    let reviewData: [ReviewModelData]?
    let ratingCount: [String: Int]?
}

// MARK: - ReviewDatum
struct ReviewModelData: Codable {
    let id: Int?
    let comment: String?
    let rating: Int?
    let createdAt: String?
    let users: ReviewUsers?
}

// MARK: - Users
struct ReviewUsers: Codable {
    let id: Int?
    let fullName: String?
    let createdAt: String?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case createdAt
        case profileImage = "profile_image"
    }
}






struct AddReviewModel: Codable {
    let reviewData: ReviewModelData?
    let success: Bool?
    let message: String?
}



struct ReviewInoutModel {
    let review: String?
    let rating: Int?
    let id: Int?
}
