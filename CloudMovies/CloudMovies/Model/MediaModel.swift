//
//  TopRated.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieResponse = try? newJSONDecoder().decode(MovieResponse.self, from: jsonData)

import Foundation

public struct MediaModel {
// MARK: - MediaResponse
    public struct MediaResponse: Codable {
        let page: Int?
        let results: [Media]?
        let totalPages, totalResults: Int?
        enum CodingKeys: String, CodingKey {
            case page, results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
    }
// MARK: - Result
    public struct Media: Codable {
        let adult: Bool?
        let backdropPath, firstAirDate: String?
        let genreIds: [Int]?
        let id: Int
        let originalLanguage, originalTitle, overview: String?
        let popularity: Double?
        let posterPath: String?
        let releaseDate: String?
        let title, name: String?
        let voteAverage: Double?
        let voteCount: Int?
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case firstAirDate = "first_air_date"
            case genreIds = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title
            case name
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}
