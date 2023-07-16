//
//  MarvelComics.swift
//  desafio
//
//  Created by Andre Dias on 15/07/23.
//

import Foundation

// MARK: - MarvelComicsResponse
struct MarvelComicsResponse: Codable {
    let attributionText: String
    let data: MarvelComicsData
}

// MARK: - DataClass
struct MarvelComicsData: Codable {
    let results: [MarvelComicsResult]
}

// MARK: - Result
struct MarvelComicsResult: Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: MarvelComicsThumbnail

    enum CodingKeys: String, CodingKey {
        case id
        case title, description, thumbnail
    }
}

// MARK: - Thumbnail
struct MarvelComicsThumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
