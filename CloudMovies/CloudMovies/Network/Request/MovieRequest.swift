//
//  PopularMovieRequest.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//

import Foundation

struct MovieRequest: DataRequest {
    
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"
    var url: String {
        let baseURL: String = "https://api.themoviedb.org/3"
        let path: String = "/discover/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=28&with_watch_monetization_types=flatrate"
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
        let response = try decoder.decode(MovieResponse.self, from: data)
        return response.results
    }
}
