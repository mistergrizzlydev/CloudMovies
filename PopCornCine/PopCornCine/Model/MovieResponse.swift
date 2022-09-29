//
//  PopularMovieRequest.swift
//  PopCornCine
//
//  Created by Артем Билый on 29.09.2022.
//

import UIKit

// MARK: - MovieResponse
public struct MoviesResponse: Codable {
    public let page: Int?
    public let results: [Movie]
    public let totalPages: Int?
    public let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
public struct Movie: Codable {
    public let adult: Bool
    public let backdropPath: String
    public let genreIds: [Int]
    public let id: Int
    public let originalTitle, overview: String
    public let popularity: Double
    public let posterPath, releaseDate, title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    
    public var posterURL: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath)"
        
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIds = "genre_ids"
            case id
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}
