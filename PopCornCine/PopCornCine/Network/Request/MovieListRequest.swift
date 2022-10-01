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
    var url: String {
        let baseURL: String = "https://api.themoviedb.org/3/discover"
        let path: String = "/movie?api_key=\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&primary_release_date.gte=1990-01-01&primary_release_date.lte=1999-12-31&vote_average.gte=6&with_genres=28"
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
    
    func decode(_ data: Data) throws -> [Movie]? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(MoviesResponse.self, from: data)
        return response.results
    }
}
