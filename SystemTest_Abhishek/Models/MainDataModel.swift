//
//  CountryModel.swift
//  InfosysExercise_Abhi
//
//  Created by Abhishek Nagar on 06/07/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation

// MARK: - MainDataModel
struct MainDataModel: Codable {
    let type: String?
    let instrumentation: Instrumentation?
    let readLink, webSearchURL: String?
    let queryContext: QueryContext?
    let totalEstimatedMatches, nextOffset, currentOffset: Int?
    let value: [Value]?
    let queryExpansions: [QueryExpansion]?
    let pivotSuggestions: [PivotSuggestion]?
    let similarTerms: [SimilarTerm]?
    let relatedSearches: [QueryExpansion]?

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case instrumentation, readLink
        case webSearchURL = "webSearchUrl"
        case queryContext, totalEstimatedMatches, nextOffset, currentOffset, value, queryExpansions, pivotSuggestions, similarTerms, relatedSearches
    }
}

// MARK: - Instrumentation
struct Instrumentation: Codable {
    let type: String?

    enum CodingKeys: String, CodingKey {
        case type = "_type"
    }
}

// MARK: - PivotSuggestion
struct PivotSuggestion: Codable {
    let pivot: String?
    let suggestions: [QueryExpansion]?
}

// MARK: - QueryExpansion
struct QueryExpansion: Codable {
    let text, displayText: String?
    let webSearchURL, searchLink: String?
    let thumbnail: QueryExpansionThumbnail?

    enum CodingKeys: String, CodingKey {
        case text, displayText
        case webSearchURL = "webSearchUrl"
        case searchLink, thumbnail
    }
}

// MARK: - QueryExpansionThumbnail
struct QueryExpansionThumbnail: Codable {
    let thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case thumbnailURL = "thumbnailUrl"
    }
}

// MARK: - QueryContext
struct QueryContext: Codable {
    let originalQuery, alterationDisplayQuery, alterationOverrideQuery, alterationMethod: String?
    let alterationType: String?
}

// MARK: - SimilarTerm
struct SimilarTerm: Codable {
    let text, displayText: String?
    let webSearchURL: String?
    let thumbnail: SimilarTermThumbnail?

    enum CodingKeys: String, CodingKey {
        case text, displayText
        case webSearchURL = "webSearchUrl"
        case thumbnail
    }
}

// MARK: - SimilarTermThumbnail
struct SimilarTermThumbnail: Codable {
    let url: String?
}

// MARK: - Value
struct Value: Codable {
    let webSearchURL: String?
    let name: String?
    let thumbnailURL: String?
    let datePublished: String?
    let isFamilyFriendly: Bool?
    let creativeCommons: String?
    let contentURL: String?
    let hostPageURL: String?
    let contentSize: String?
    let encodingFormat: EncodingFormat?
    let hostPageDisplayURL: String?
    let width, height: Int?
    let hostPageFavIconURL: String?
    let hostPageDomainFriendlyName: String?
    let thumbnail: ValueThumbnail?
    let imageInsightsToken: String?
    let insightsMetadata: InsightsMetadata?
    let imageID, accentColor: String?

    enum CodingKeys: String, CodingKey {
        case webSearchURL = "webSearchUrl"
        case name
        case thumbnailURL = "thumbnailUrl"
        case datePublished, isFamilyFriendly, creativeCommons
        case contentURL = "contentUrl"
        case hostPageURL = "hostPageUrl"
        case contentSize, encodingFormat
        case hostPageDisplayURL = "hostPageDisplayUrl"
        case width, height
        case hostPageFavIconURL = "hostPageFavIconUrl"
        case hostPageDomainFriendlyName, thumbnail, imageInsightsToken, insightsMetadata
        case imageID = "imageId"
        case accentColor
    }
}

enum EncodingFormat: String, Codable {
    case jpeg = "jpeg"
    case png = "png"
}

// MARK: - InsightsMetadata
struct InsightsMetadata: Codable {
    let pagesIncludingCount, availableSizesCount, recipeSourcesCount: Int?
    let videoObject: VideoObject?
}

// MARK: - VideoObject
struct VideoObject: Codable {
    let creator: Creator?
    let duration: String?
}

// MARK: - Creator
struct Creator: Codable {
    let name: String?
}

// MARK: - ValueThumbnail
struct ValueThumbnail: Codable {
    let width, height: Int?
}

