//
//  Model.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/19/23.
//

import Foundation



struct MyWishlistModel: Codable {
    let success: Bool?
    let wishlist: [Wishlist]?
}

// MARK: - Catalogues
struct Catalogues: Codable {
    let id: Int?
    let title, slug, additionalFilters, colors: String?
    let watchCount: Int?
    let totalRating: String?
    let totalReviews: Int?
    let categories: Wishlist?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case additionalFilters = "additional_filters"
        case colors
        case watchCount = "watch_count"
        case totalRating = "TotalRating"
        case totalReviews = "TotalReviews"
        case categories, items
    }
}

// MARK: - Product
struct Product: Codable {
    let id, userID: Int?
    let catalogues: Catalogues?
    let image: String?
    let minPrice: Double?
    let maxPrice: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case catalogues, image
        case minPrice = "min_price"
        case maxPrice = "max_price"
    }
}

// MARK: - Wishlist
struct Wishlist: Codable {
    let id: Int?
    let category, categoryAr: String?
    let products: [Product]?

    enum CodingKeys: String, CodingKey {
        case id, category
        case categoryAr = "category_ar"
        case products
    }
}

// MARK: - Item
struct Item: Codable {
    let price: String?
    let image: String?
    let brand: String?
}
