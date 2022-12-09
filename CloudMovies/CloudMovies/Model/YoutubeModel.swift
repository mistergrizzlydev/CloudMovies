//
//  YoutubeModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 09.11.2022.
//

import Foundation
// MARK: - VideoModel
struct VideoResponse: Codable {
    let id: Int
    let results: [Video]
}
// MARK: - Video
extension VideoResponse {
    struct Video: Codable {
        let name, key: String
        let site: String
        let size: Int
        let type: String
        let official: Bool
        let publishedAt, id: String
    }
}
