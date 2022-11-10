//
//  MovieDetailsResponse.swift
//  CloudMovies
//
//  Created by Артем Билый on 27.10.2022.
//

import Foundation

// MARK: - SingleMovieResponse
public struct MovieDetailsModel {
    // MARK: Movie Response
    struct MovieResponse: Codable {
        let adult: Bool?
        let backdropPath: String?
        let budget: Int?
        let genres: [Genre]?
        let homepage: String?
        let id: Int?
        let imdbId: String?
        let originalTitle, overview: String?
        let popularity: Double?
        let posterPath: String?
        let releaseDate: String?
        let revenue, runtime: Int?
        let status, tagline, title: String?
        let voteAverage: Double?
        let voteCount: Int?
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case budget, genres, homepage, id
            case imdbId = "imdb_id"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case revenue, runtime
            case status, tagline, title
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
    // MARK: Genre
    struct Genre: Codable {
        let id: Int?
        let name: String?
    }
    // MARK: Videos
    enum Site: String, Codable {
        case youTube = "YouTube"
    }

}
