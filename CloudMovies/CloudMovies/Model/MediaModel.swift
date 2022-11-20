//
//  MovieDetailsResponse.swift
//  CloudMovies
//
//  Created by Артем Билый on 27.10.2022.
//

// MARK: - SingleMovieResponse
public struct MediaModel {
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
    // MARK: Movie Response
    struct Media: Codable {
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
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case firstAirDate = "first_air_date"
            case budget, genres, homepage, id
            case imdbId = "imdb_id"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case revenue, runtime
            case status, tagline, title, name
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
