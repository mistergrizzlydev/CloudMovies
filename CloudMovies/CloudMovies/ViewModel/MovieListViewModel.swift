//
//  GenreList.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//
//

import Foundation

protocol MovieListViewModel: AnyObject {
    
    var topRated: [Movie] { get set }
    var onGoind: [Movie] { get set }
    var popular: [Movie] { get set }
    var upcoming: [Movie] { get set }
    
    var genresMovies: [Genre] { get set }
    var genresTVShows: [Genre] { get set }
    var movies: [Movie] { get set }
    var tvShow: [TVShow] { get set }
    
    var sortedMovies: [String: [Movie]] { get set }
    var sortedTVShow: [String: [TVShow]] { get set }
    
    func getDiscoverScreen(completion: @escaping(() -> ()))
    func getGenresMovie(completion: @escaping(([Genre]) -> ()))
    func getGenresTVShows(completion: @escaping(([Genre]) -> ()))
    func sortedMovies(completion: @escaping(() -> ()))
    func sortedTVShows(completion: @escaping(() -> ()))
}

final class MovieListDefaultViewModel: MovieListViewModel  {
    
    var topRated: [Movie] = []
    var onGoind: [Movie] = []
    var popular: [Movie] = []
    var upcoming: [Movie] = []
    
    var genresMovies: [Genre] = []
    var genresTVShows: [Genre] = []
    var movies: [Movie] = []
    var tvShow: [TVShow] = []
    
    var sortedTVShow: [String: [TVShow]] = [:]
    var sortedMovies: [String: [Movie]] = [:]
    
    //MAKE NETWORK SERVICE AND GLOBAL CONSTANT // ENUMS FOR REQUESTS
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"
    
    var genresMovieURL: String {
        let pathURL: String = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US"
        return pathURL
    }
    
    var genresTVShowURL: String {
        let pathURL: String = "https://api.themoviedb.org/3/genre/tv/list?api_key=\(apiKey)&language=en-US"
        return pathURL
    }
    
    var popularMovieURL: String {
        let pathURL: String = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        return pathURL
    }
    
    var topRatedMovieURL: String {
        let pathURL: String = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1"
        return pathURL
    }
    
    var onGoindMovieURL: String {
        let pathURL: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1"
        return pathURL
    }
    
    var upcomingMovieURL: String {
        let pathURL: String = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=en-US&page=1"
        return pathURL
    }
    
    func getDiscoverScreen(completion: @escaping(() -> ())) {
        getPopularMovies { movies in
            self.popular = movies
        }
        
        getTopRatedMovies { movies in
            self.topRated = movies
        }
        
        getOnGoindMovies { movies in
            self.onGoind = movies
        }
        
        getUpcomingMovies { movies in
            self.upcoming = movies
        }
        completion()
    }
    
    func getPopularMovies(completion: @escaping(([Movie]) -> ())) {
        guard let apiURL = URL(string: popularMovieURL) else {
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
    
    func getOnGoindMovies(completion: @escaping(([Movie]) -> ())) {
        guard let apiURL = URL(string: onGoindMovieURL) else {
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
    
    func getTopRatedMovies(completion: @escaping(([Movie]) -> ())) {
        guard let apiURL = URL(string: topRatedMovieURL) else {
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
    
    func getUpcomingMovies(completion: @escaping(([Movie]) -> ())) {
        guard let apiURL = URL(string: upcomingMovieURL) else {
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
    
    
    
    func getGenresMovie(completion: @escaping(([Genre]) -> ())) {
        guard let apiURL = URL(string: genresMovieURL) else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GenresResponse.self, from: data)
                self.genresMovies = response.genres
                completion(response.genres)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func getGenresTVShows(completion: @escaping(([Genre]) -> ())) {
        guard let apiURL = URL(string: genresTVShowURL) else {
            fatalError("Invalid URL")
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GenresResponse.self, from: data)
                self.genresTVShows = response.genres
                completion(response.genres)
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func sortedMovies(completion: @escaping(() -> ())) {
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
                        DispatchQueue.main.async {
                            self.sortedMovies[genre.name] = response.results
                        }
                        completion()
                    } catch {
                        print("Error: \(error)")
                    }
                }
                task.resume()
            }
        }
    }
    
    func sortedTVShows(completion: @escaping(() -> ())) {
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
                        DispatchQueue.main.async {
                            self.sortedTVShow[genre.name] = response.results
                        }
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
