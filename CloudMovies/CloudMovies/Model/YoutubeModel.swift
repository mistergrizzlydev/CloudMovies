//
//  YoutubeModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 09.11.2022.
//

import Foundation

struct YoutubeModel {
    // MARK: - Welcome
    struct VideoResponse: Decodable {
        let id: Int
        let results: [Video]
    }
    // MARK: - Video
    struct Video: Decodable {
        let name, key: String
        let site: String
        let size: Int
        let type: String
        let official: Bool
        let publishedAt, id: String
    }
}
