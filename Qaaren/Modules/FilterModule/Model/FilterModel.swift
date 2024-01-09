//
//  FilterModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 1/9/24.
//

import Foundation

struct FilterModel: Codable {
    let id: Int?
    let title: String?
    let titleAr: String?
    let catalogue: [FilterCatalogue]?

    enum CodingKeys: String, CodingKey {
        case id, title
        case titleAr = "title_ar"
        case catalogue
    }
}

// MARK: - Catalogue
struct FilterCatalogue: Codable {
    let title: String?
    let catalogueID, watchCount: Int?
    let colors: String?
    let additionalFilters: String?
    let images: [String]?
    let minPrice, maxPrice: String?
//    let totalRating, totalReviews, totalItems: Int?
    let currency: String?
    let source: String?
    let locationType: String?
    let logoURL: String?
    let website: String?
    let category: FilterCategory?

    enum CodingKeys: String, CodingKey {
        case title
        case catalogueID = "catalogueId"
        case watchCount = "watch_count"
        case colors
        case additionalFilters = "additional_filters"
        case images, minPrice, maxPrice
//        case totalRating = "TotalRating"
//        case totalReviews = "TotalReviews"
//        case totalItems = "TotalItems"
        case currency, source, locationType
        case logoURL = "logo_url"
        case website, category
    }
}

// MARK: - Category
struct FilterCategory: Codable {
    let id: Int?
    let category: String?
    let categoryAr: String?

    enum CodingKeys: String, CodingKey {
        case id, category
        case categoryAr = "category_ar"
    }
}
