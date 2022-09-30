//
//  PopularMovieRequest.swift
//  PopCornCine
//
//  Created by Артем Билый on 29.09.2022.
//

import Foundation

struct GenreListRequest: DataRequest {
    
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"
    var url: String {
        let pathURL: String = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US"
        return pathURL
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var queryItems: [String : String] {
        [
            "api_key": apiKey
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [Genre]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(GenresResponse.self, from: data)
        return response.genres
    }
}

