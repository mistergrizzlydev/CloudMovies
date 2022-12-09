//
//  MovieDetailsResponse.swift
//  CloudMovies
//
//  Created by Артем Билый on 27.10.2022.
//

// MARK: - SingleMovieResponse
struct MediaModel {
    struct MediaResponse: Decodable {
        let page: Int?
        let results: [Media]?
        let totalPages, totalResults: Int?
    }
    // MARK: Movie Response
    struct Media: Decodable {
        let adult: Bool?
        let backdropPath: String?
        let budget: Int?
        let firstAirDate: String?
        let genres: [Genre]?
        let homepage: String?
        let id: Int?
        let imdbId: String?
        let originalTitle, overview: String?
        let popularity: Double?
        let posterPath: String?
        let releaseDate: String?
        let revenue, runtime: Int?
        let status, tagline, title, name: String?
        let voteAverage: Double?
        let voteCount: Int?
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
