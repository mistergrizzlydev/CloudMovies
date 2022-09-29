//
//  GenresResponse.swift
//  PopCornCine
//
//  Created by Артем Билый on 30.09.2022.
//

import Foundation

// MARK: - Genres
public struct Genres: Codable {
    public let genres: [Genre]?
}

// MARK: - Genre
public struct Genre: Codable {
    public let id: Int?
    public let name: String?
}
