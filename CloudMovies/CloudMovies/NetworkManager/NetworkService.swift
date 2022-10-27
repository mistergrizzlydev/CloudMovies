//
//  NetworkService.swift
//  CloudMovies
//
//  Created by Артем Билый on 25.10.2022.
//

import Foundation

class NetworkService {
    //apiKey
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"
    //MARK: - genres movie
    func getGenresMovie(completion: @escaping(([GenresModel.Genre]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/genre/\(MediaType.movie.rawValue)/list?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GenresModel.GenresResponse.self, from: data)
                completion(response.genres)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    //MARK: - genres TVShow
    func getGenresTVShows(completion: @escaping(([GenresModel.Genre]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/genre/\(MediaType.tv.rawValue)/list?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GenresModel.GenresResponse.self, from: data)
                completion(response.genres)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    //MARK: - popular movies
    func getPopularMovies(completion: @escaping(([MoviesModel.Movie]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.popular.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesModel.MovieResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    //MARK: - toprated movies
    func getTopRatedMovies(completion: @escaping(([MoviesModel.Movie]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.topRated.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesModel.MovieResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    //MARK: - nowplaying movies
    func getNowPlayingMovies(completion: @escaping(([MoviesModel.Movie]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.nowPlaying.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesModel.MovieResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    //MARK: - upcoming movies
    func getUpcomingMovies(completion: @escaping(([MoviesModel.Movie]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.upcoming.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesModel.MovieResponse.self, from: data)
                completion(response.results)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    //MARK: - sorted movies
    func sortedMovies(completion: @escaping(([String: [MoviesModel.Movie]]) -> ())) {
        getGenresMovie { response in
            var dict: [String: [MoviesModel.Movie]] = [:]
            for genre in response {
                guard let apiURL = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(self.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=\(genre.id)&with_watch_monetization_types=flatrate") else {
                    fatalError("Invalid URL")
                }
                
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: apiURL) { data, response, error in
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(MoviesModel.MovieResponse.self, from: data)
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
    //MARK: - sorted TVShows
    func sortedTVShows(completion: @escaping(([String: [TVShowsModel.TVShow]]) -> ())) {
        getGenresTVShows { response in
            var dict: [String: [TVShowsModel.TVShow]] = [:]
            for genre in response {
                guard let apiURL = URL(string: "https://api.themoviedb.org/3/discover/tv?api_key=\(self.apiKey)&sort_by=popularity.desc&with_genres=\(genre.id)") else {
                    fatalError("Invalid URL")
                }
                
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: apiURL) { data, response, error in
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(TVShowsModel.TVShowResponse.self, from: data)
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
    //MARK: - search request
    func getSearchedMovies(query: String, page: Int = 1, completion: @escaping ((MoviesModel.MovieResponse) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(query)&page=\(page)") else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesModel.MovieResponse.self, from: data)
                completion(response)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
}

