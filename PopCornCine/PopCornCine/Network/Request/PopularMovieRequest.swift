//
//  PopularMovieRequest.swift
//  PopCornCine
//
//  Created by Артем Билый on 29.09.2022.
//

import Foundation

import Foundation

struct PopularMovieRequest: DataRequest {
    
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"

    var url: String {
        let baseURL: String = "https://api.themoviedb.org/3"
        let path: String = "/movie/popular"
        return baseURL + path
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
    
    func decode(_ data: Data) throws -> [Movie] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(MoviesResponse.self, from: data)
        return response.results
    }
}
