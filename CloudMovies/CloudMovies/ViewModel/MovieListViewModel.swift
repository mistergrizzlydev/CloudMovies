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
    func sortedMovies(completion: @escaping(() -> ()))
    func sortedTVShows(completion: @escaping(() -> ()))
}

final class MovieListDefaultViewModel: MovieListViewModel {

    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    
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
    
    
    func getDiscoverScreen(completion: @escaping(() -> ())) {
        networkManager.getUpcomingMovies { result in
            self.upcoming = result
            self.upcoming.shuffle()
        }
        networkManager.getPopularMovies { result in
            self.popular = result
            self.popular.shuffle()
        }
        networkManager.getTopRatedMovies { result in
            self.topRated = result
            self.topRated.shuffle()
            
        }
        networkManager.getNowPlayingMovies { result in
            self.onGoind = result
            self.onGoind.shuffle()
        }
        completion()
    }
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"
    
    func sortedMovies(completion: @escaping(() -> ())) {
        networkManager.getGenresMovie { response in
            self.genresMovies = response
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
        networkManager.sortedTVShows { tvshow in
            self.sortedTVShow = tvshow
        }
    }
}
