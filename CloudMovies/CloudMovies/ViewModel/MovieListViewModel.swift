//
//  GenreList.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//
//

import Foundation

protocol MovieListViewModel: AnyObject {
    var genres: [Genre] { get set }
    var movies: [Movie] { get set }
    var sortedMovies: [String: [Movie]] { get set }
    
    func sortedByGenres(completion: @escaping(() -> ()))
    func getGenres(completion: @escaping(([Genre]) -> ()))
}

final class MovieListDefaultViewModel: MovieListViewModel  {
    var genres: [Genre] = []
    var movies: [Movie] = []
    var sortedMovies: [String: [Movie]] = [:]
    //make it global const
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"
    
    var genresURL: String {
        let pathURL: String = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US"
        return pathURL
    }
    
    func getGenres(completion: @escaping(([Genre]) -> ())) {
        guard let apiURL = URL(string: genresURL) else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GenresResponse.self, from: data)
                self.genres = response.genres
                completion(response.genres)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func sortedByGenres(completion: @escaping(() -> ())) {
        getGenres { response in
            for genre in response {
                guard let apiURL = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(self.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genre.id)&with_watch_monetization_types=flatrate") else {
                    fatalError("Invalid URL")
                }
                
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: apiURL) { data, response, error in
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(MovieResponse.self, from: data)
                        self.sortedMovies[genre.name] = response.results
                        completion()
                    } catch {
                        print("Error: \(error)")
                    }
                }
                task.resume()
            }
        }
    }
}
