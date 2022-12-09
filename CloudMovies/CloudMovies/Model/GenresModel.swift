//
//  GenreResponse.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
// 
import Foundation

struct GenresResponse: Codable {
    let genres: [Genre]?
}
extension GenresResponse {
    struct Genre: Codable {
        let id: Int?
        let name: String?
    }
}
