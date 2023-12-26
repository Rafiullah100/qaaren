//
//  SearchModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/26/23.
//

import Foundation


struct SearchModel: Codable {
    let success: Bool?
    let message: String?
    let catalogue: [SearchCatalogue]?
}

// MARK: - Catalogue
struct SearchCatalogue: Codable {
    let id: Int?
    let title: String?
    let items: [SearchItem]?
    let categories: SearchCategories?
    let subCategories: SearchSubCategories?

    enum CodingKeys: String, CodingKey {
        case id, title, items, categories
        case subCategories = "sub_categories"
    }
}

// MARK: - Categories
struct SearchCategories: Codable {
    let id: Int?
    let category: String?
}

// MARK: - Item
struct SearchItem: Codable {
    let id: Int?
    let brand: String?
    let item: String?
}

// MARK: - SubCategories
struct SearchSubCategories: Codable {
    let id: Int?
    let title: String?
}
