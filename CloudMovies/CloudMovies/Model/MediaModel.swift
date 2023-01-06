//
//  MovieDetailsResponse.swift
//  CloudMovies
//
//  Created by Артем Билый on 27.10.2022.
//

// MARK: - SingleMovieResponse
struct MediaResponse: Decodable {
    let page: Int?
    let results: [Media]?
    let totalPages, totalResults: Int?
}

extension MediaResponse {
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
}

extension MediaResponse.Media {
    struct Genre: Decodable {
        let id: Int?
        let name: String?
    }
}
