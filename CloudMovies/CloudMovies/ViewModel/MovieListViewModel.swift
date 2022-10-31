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
    
    private(set) var popularTVShows: [TVShowsModel.TVShow] = []
    private(set) var topRatedTVShows: [TVShowsModel.TVShow] = []
    private(set) var thisWeekTVShows: [TVShowsModel.TVShow] = []
    private(set) var newEpisodes: [TVShowsModel.TVShow] = []
    
    private(set) var sortedTVShow: [String: [TVShowsModel.TVShow]] = [:]
    private(set) var sortedMovies: [String: [MoviesModel.Movie]] = [:]
    
    
    weak var delegate: ViewModelProtocol?
    
    func getDiscoverScreen() {
        networkManager.getUpcomingMovies { result in
            self.upcoming = result
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
        }
        networkManager.getPopularTVShows { result in
            self.popularTVShows = result
        }
        networkManager.getTopRatedTVShows { result in
            self.topRatedTVShows = result
        }
        networkManager.getThisWeek { result in
            self.thisWeekTVShows = result
        }
        networkManager.getNewEpisodes { result in
            self.newEpisodes = result
        }
        self.delegate?.updateView()
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
