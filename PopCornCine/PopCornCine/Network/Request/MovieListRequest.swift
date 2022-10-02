//
//  PopularMovieRequest.swift
//  PopCornCine
//
//  Created by Артем Билый on 29.09.2022.
//

import Foundation

struct MovieListRequest: DataRequest {
    //add logic to switch genres.
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"
    var url: String = "https://api.themoviedb.org/3/movie/popular?api_key=b3187cf196a7681dee8805cdcec0d6ba&language=en-US&page=2    "
    
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
    
    func decode(_ data: Data) throws -> [Movie]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(MoviesResponse.self, from: data)
        return response.results
    }
}
