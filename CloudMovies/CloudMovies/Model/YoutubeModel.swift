//
//  YoutubeModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 09.11.2022.
//

import Foundation

public struct YoutubeModel {
    // MARK: - Welcome
    struct VideoResponse: Codable {
        let id: Int
        let results: [Video]
    }
    // MARK: - Video
    struct Video: Codable {
        let name, key: String
        let site: String
        let size: Int
        let type: String
        let official: Bool
        let publishedAt, id: String
        enum CodingKeys: String, CodingKey {
            case name, key, site, size, type, official
            case publishedAt = "published_at"
            case id
        }
    }
}
