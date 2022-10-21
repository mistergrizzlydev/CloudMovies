//
//  TopRated.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//
import Foundation

// MARK: - MovieResponse
public struct MovieResponse: Codable {
    public let page: Int?
    public let results: [Movie]?
    public let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
public struct Movie: Codable {
    public let adult: Bool
    public let backdropPath: String?
    public let genreIds: [Int]
    public let id: Int
    let originalLanguage: String
    public let originalTitle, overview: String
    public let popularity: Double
    public let posterPath, releaseDate, title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int
    public var posterURL: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case es = "es"
//    case fr = "fr"
//    case ja = "ja"
//}
