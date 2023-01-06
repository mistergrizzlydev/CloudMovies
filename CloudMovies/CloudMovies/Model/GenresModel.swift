//
//  GenreResponse.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
// 
import Foundation

struct GenresResponse: Decodable {
    let genres: [Genre]?
}
extension GenresResponse {
    struct Genre: Decodable {
        let id: Int?
        let name: String?
    }
}
