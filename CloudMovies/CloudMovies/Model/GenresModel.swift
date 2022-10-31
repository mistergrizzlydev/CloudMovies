//
//  GenreResponse.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
// 
import Foundation
// MARK: - Genres Model
public struct GenresModel {
    // MARK: Genres Response
    public struct GenresResponse: Codable {
        public let genres: [Genre]?
    }
    // MARK: Genre
    public struct Genre: Codable {
        public let id: Int?
        public let name: String?
    }
}
