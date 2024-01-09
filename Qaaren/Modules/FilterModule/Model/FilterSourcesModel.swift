//
//  FilterModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/18/23.
//

import Foundation

struct FilterSourcesModel: Codable {
    let status: Int?
    let sources: [FilterSourceData]?
}

// MARK: - Source
struct FilterSourceData: Codable {
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
    let checked: Bool?

    enum CodingKeys: String, CodingKey {
        case id, source, slug, website
        case logoURL = "logo_url"
        case status, currency, locationType, locationLat, locationLng, address, isDelete, createdAt, updatedAt, checked
    }
}
