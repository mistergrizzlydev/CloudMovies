//
//  TVShowResponse.swift
//  CloudMovies
//
//  Created by Артем Билый on 23.10.2022.
//

import Foundation

// MARK: - MovieResponse
public struct TVShowsModel {
    public struct TVShowResponse: Codable {
        let page: Int?
        let results: [TVShow]?
        let totalPages, totalResults: Int?
        
        enum CodingKeys: String, CodingKey {
            case page, results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
    }
    
    // MARK: - Result
    public struct TVShow: Codable {
        let backdropPath, firstAirDate: String?
        let genreIds: [Int]?
        let id: Int?
        let name: String?
        let originCountry: [String]?
        let originalLanguage, originalName, overview: String?
        let popularity: Double?
        let posterPath: String?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case firstAirDate = "first_air_date"
            case genreIds = "genre_ids"
            case id, name
            case originCountry = "origin_country"
            case originalLanguage = "original_language"
            case originalName = "original_name"
            case overview, popularity
            case posterPath = "poster_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}
