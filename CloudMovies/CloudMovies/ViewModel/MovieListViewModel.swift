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
    
    weak var delegate: ViewModelProtocol?
    
    func getDiscoverScreen() {
        networkManager.getUpcomingMovies { result in
            self.upcoming = result
            self.upcoming.shuffle()
            self.delegate?.updateView()
        }
        networkManager.getPopularMovies { result in
            self.popular = result
            self.popular.shuffle()
            
        }
        networkManager.getTopRatedMovies { result in
            self.topRated = result
            self.topRated.shuffle()
            self.delegate?.updateView()
        }
        networkManager.getNowPlayingMovies { result in
            self.onGoind = result
            self.onGoind.shuffle()
            self.delegate?.updateView()
        }
        
    }
    
    func getSortedMovies() {
        networkManager.sortedMovies { movies in
            self.sortedMovies = movies
            self.delegate?.updateView()
        }
    }
    
    func getSortedTVShows() {
        networkManager.sortedTVShows { tvshow in
            self.sortedTVShow = tvshow
            self.delegate?.updateView()
            
        }
    }
}
