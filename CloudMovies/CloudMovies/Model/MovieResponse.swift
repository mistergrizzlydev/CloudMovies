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

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let dates: Dates?
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result
struct Movie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

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


//// MARK: - MovieResponse
//public struct MovieResponse: Codable {
//    public let page: Int?
//    public let results: [Movie]
//    public let totalPages, totalResults: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
//    }
//}
//
//// MARK: - Result
//public struct Movie: Codable {
//    public let adult: Bool?
//    public let backdropPath: String?
//    public let genreIds: [Int]?
//    public let id: Int?
//    let originalLanguage: String?
//    public let originalTitle, overview: String
//    public let popularity: Double
//    public let posterPath, releaseDate, title: String?
//    public let video: Bool?
//    public let voteAverage: Double
//    public let voteCount: Int?
//    public var posterURL: String {
//        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIds = "genre_ids"
//        case id
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//}
//
////enum OriginalLanguage: String, Codable {
////    case en = "en"
////    case es = "es"
////    case fr = "fr"
////    case ja = "ja"
////}
