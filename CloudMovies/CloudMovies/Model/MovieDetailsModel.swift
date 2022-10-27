//
//  MovieDetailsResponse.swift
//  CloudMovies
//
//  Created by Артем Билый on 27.10.2022.
//

import Foundation

// MARK: - MovieResponse
public struct MovieDetailsModel {
    struct MovieResponse: Codable {
        let adult: Bool?
        let backdropPath: String?
        let budget: Int?
        let genres: [Genre]?
        let homepage: String?
        let id: Int?
        let imdbId, originalLanguage, originalTitle, overview: String?
        let popularity: Double?
        let posterPath: String?
        let productionCountries: [ProductionCountry]?
        let releaseDate: String?
        let revenue, runtime: Int?
        let spokenLanguages: [SpokenLanguage]?
        let status, tagline, title: String?
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?
        
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case budget, genres, homepage, id
            case imdbId = "imdb_id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case productionCountries = "production_countries"
            case releaseDate = "release_date"
            case revenue, runtime
            case spokenLanguages = "spoken_languages"
            case status, tagline, title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
    // MARK: - Genre
    struct Genre: Codable {
        let id: Int?
        let name: String?
    }
    // MARK: - ProductionCountry
    struct ProductionCountry: Codable {
        let iso3166_1, name: String?
        
        enum CodingKeys: String, CodingKey {
            case iso3166_1 = "iso_3166_1"
            case name
        }
    }
    // MARK: - SpokenLanguage
    struct SpokenLanguage: Codable {
        let englishName, iso639_1, name: String?
        
        enum CodingKeys: String, CodingKey {
            case englishName = "english_name"
            case iso639_1 = "iso_639_1"
            case name
        }
    }
}
