//
//  GenreList.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//
//

import Foundation

final class MovieListDefaultViewModel {

    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    
    private(set) var topRated: [MoviesModel.Movie] = []
    private(set) var onGoind: [MoviesModel.Movie] = []
    private(set) var popular: [MoviesModel.Movie] = []
    private(set) var upcoming: [MoviesModel.Movie] = []
    private(set) var sortedTVShow: [String: [TVShowsModel.TVShow]] = [:]
    private(set) var sortedMovies: [String: [MoviesModel.Movie]] = [:]
    
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
    
    func sortedMovies(completion: @escaping(() -> ())) {
        networkManager.sortedMovies { movies in
            self.sortedMovies = movies
        }
        completion()
    }
    
    func sortedTVShows(completion: @escaping(() -> ())) {
        networkManager.sortedTVShows { tvshow in
            self.sortedTVShow = tvshow
        }
        completion()
    }
}
