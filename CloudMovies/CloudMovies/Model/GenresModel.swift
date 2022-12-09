//
//  GenreResponse.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
// 
import Foundation
// MARK: - Genres Model
struct GenresModel {
    // MARK: Genres Response
    struct GenresResponse: Decodable {
        let genres: [Genre]?
    }
    // MARK: Genre
    struct Genre: Decodable {
        let id: Int?
        let name: String?
    }
}
