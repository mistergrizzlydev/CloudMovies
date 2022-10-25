//
//  NetworkService.swift
//  CloudMovies
//
//  Created by Артем Билый on 25.10.2022.
//

import Foundation

enum MediaType: String {
    case movie
    case tv
}

enum MediaSection: String {
    case popular
    case topRated   = "top_rated"
    case nowPlaying = "now_playing"
    case upcoming
    
}

class NetworkService {
    
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"
    
    func getGenresMovie(completion: @escaping(([Genre]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/genre/\(MediaType.movie.rawValue)/list?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GenresResponse.self, from: data)
                completion(response.genres)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    
    func getGenresTVShows(completion: @escaping(([Genre]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/genre/\(MediaType.tv.rawValue)/list?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GenresResponse.self, from: data)
                completion(response.genres)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping(([Movie]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.popular.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping(([Movie]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.topRated.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func getNowPlayingMovies(completion: @escaping(([Movie]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.nowPlaying.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping(([Movie]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.upcoming.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func sortedMovies(completion: @escaping(([Movie]) -> ())) {
        getGenresMovie { response in
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
                        completion(response.results)
                    } catch {
                        print("Error: \(error)")
                    }
                }
                task.resume()
            }
        }
    }
    
    func sortedTVShows(completion: @escaping(([String: [TVShow]]) -> ())) {
        getGenresTVShows { response in
            for genre in response {
                guard let apiURL = URL(string: "https://api.themoviedb.org/3/discover/tv?api_key=\(self.apiKey)&sort_by=popularity.desc&with_genres=\(genre.id)") else {
                    fatalError("Invalid URL")
                }
                
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: apiURL) { data, response, error in
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(TVShowResponse.self, from: data)
                        var dict: [String: [TVShow]] = [:]
                        dict[genre.name] = response.results
                        completion(dict)
                    } catch {
                        print("Error: \(error)")
                    }
                }
                task.resume()
            }
        }
    }
//    func sortedMovies(completion: @escaping(() -> ())) {
//        getGenresMovie { response in
//            for genre in response {
//                guard let apiURL = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(self.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genre.id)&with_watch_monetization_types=flatrate") else {
//                    fatalError("Invalid URL")
//                }
//
//                let session = URLSession(configuration: .default)
//                let task = session.dataTask(with: apiURL) { data, response, error in
//                    guard let data = data else { return }
//                    do {
//                        let decoder = JSONDecoder()
//                        let response = try decoder.decode(MovieResponse.self, from: data)
//                        DispatchQueue.main.async {
//                            self.sortedMovies[genre.name] = response.results
//                        }
//                        completion()
//                    } catch {
//                        print("Error: \(error)")
//                    }
//                }
//                task.resume()
//            }
//        }
//    }
}
