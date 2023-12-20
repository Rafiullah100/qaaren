//
//  AllCategoryModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/18/23.
//

import Foundation

struct AllCategoryModel: Codable {
    let status: Int?
    let categories: [AllCategory]?
}

// MARK: - Category
struct AllCategory: Codable {
    let id: Int?
    let categoryAr, category: String?
    var checked: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryAr = "category_ar"
        case category, checked
    }
}



////////////////////////////////////////////////////////////////////////////////////////
struct AllSourcesModel: Codable {
    let status: Int?
    let sources: [sources]?
}

// MARK: - Source
struct sources: Codable {
    let id: Int?
    let source: String?
    let slug: String?
    let website: String?
    let logoURL: String?
    let status: Int?
    let currency: String?
    let locationType: String?
    let locationLat, locationLng: String?
    let address: String?
    let isDelete: Int?
    let createdAt, updatedAt: String?
    var checked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, source, slug, website
        case logoURL = "logo_url"
        case status, currency, locationType, locationLat, locationLng, address, isDelete, createdAt, updatedAt, checked
    }
}

struct SuccessModel: Codable {
    let status: Int?
    let message: String?
}

struct FavoritModel: Codable {
    let status: Bool?
    let message: String?
}


struct AlertModel: Codable {
    let success: Bool?
    let message: String?
}

