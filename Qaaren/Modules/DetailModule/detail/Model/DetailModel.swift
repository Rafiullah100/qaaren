//
//  DetailModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/8/23.
//

import Foundation

struct DetailModel: Codable {
    let itemDetail: ItemDetail?
    let relatedItems: [DetailRelatedItem]?
    let comparisons: [Comparison]?

    enum CodingKeys: String, CodingKey {
        case itemDetail = "Item_detail"
        case relatedItems = "related_items"
        case comparisons
    }
}

// MARK: - Comparison
struct Comparison: Codable {
    let id: Int?
    let brand, item, slug, price: String?
    let link: String?
    let image: String?
    let description: String?
    let metaTitle: String?
    let metaDescription: String?
    let catalogueID, sourceID, status, isDelete: Int?
    let createdAt, updatedAt, source: String?
    let website: String?
    let logoURL: String?
    let statusScrap: Int?
    let currency: String?
    let locationType: String?
    let locationLat, locationLng, address: String?

    enum CodingKeys: String, CodingKey {
        case id, brand, item, slug, price, link, image, description
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
        case catalogueID = "catalogue_id"
        case sourceID = "source_id"
        case status, isDelete, createdAt, updatedAt, source, website
        case logoURL = "logo_url"
        case statusScrap = "status_scrap"
        case currency, locationType, locationLat, locationLng, address
    }
}

// MARK: - ItemDetail
struct ItemDetail: Codable {
    let id: Int?
    let title, slug, additionalFilters, colors: String?
    let categoryID, subCategoryID, status, watchCount: Int?
    let isDelete: Int?
    let createdAt, updatedAt: String?
    let totalReviews: [DetailTotalReview]?
    let totalReviewsCount: [DetailTotalReviewsCount]?
//    let totalLikes, likes: [JSONAny]?
    let images: [String]?
    let description: String?
    let isWishlist: Bool?
    enum CodingKeys: String, CodingKey {
        case id, title, slug
        case additionalFilters = "additional_filters"
        case colors
        case categoryID = "category_id"
        case subCategoryID = "sub_category_id"
        case status
        case watchCount = "watch_count"
        case isDelete, createdAt, updatedAt
        case totalReviews = "total_reviews"
        case totalReviewsCount = "total_reviews_count"
//        case totalLikes = "total_likes"
        case /*likes,*/ images, description
        case isWishlist = "is_wishlist"
    }
}

// MARK: - TotalReview
struct DetailTotalReview: Codable {
    let totalReviews: String?

    enum CodingKeys: String, CodingKey {
        case totalReviews = "total_reviews"
    }
}

// MARK: - TotalReviewsCount
struct DetailTotalReviewsCount: Codable {
    let totalReviewsCount: Int?

    enum CodingKeys: String, CodingKey {
        case totalReviewsCount = "total_reviews_count"
    }
}

// MARK: - RelatedItem
struct DetailRelatedItem: Codable {
    let category, categoryAr, subcategory, subcategoryAr: String?
    let image: String?
    let description: String?
    let itemID: Int?
    let currency, catalogue, price: String?
    let totalLike: String?
    let totalRating: String?
    let totalReviews: Int?
    let sourceCount: Int?

    enum CodingKeys: String, CodingKey {
        case category
        case categoryAr = "category_ar"
        case subcategory
        case subcategoryAr = "subcategory_ar"
        case image, description
        case itemID = "itemId"
        case currency, catalogue, price
        case totalLike = "TotalLike"
        case totalRating = "TotalRating"
        case totalReviews = "TotalReviews"
        case sourceCount = "SourceCount"
    }
}
