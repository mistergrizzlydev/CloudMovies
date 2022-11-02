//
//  WatchListViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 01.11.2022.
//

import Foundation

class WatchListViewModel {
    private(set) var movies: [MoviesModel.Movie] = []
    private(set) var tvShows: [TVShowsModel.TVShow] = []
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
//    func getFullWatchList() {
//        networkManager.getWatchListMovie(accountID: <#T##Int#>, sessionID: <#T##String#>, completion: <#T##((MoviesModel.MovieResponse) -> Void)##((MoviesModel.MovieResponse) -> Void)##(MoviesModel.MovieResponse) -> Void#>)
//        networkManager.getWatchListTVShows(accountID: <#T##Int#>, sessionID: <#T##String#>, completion: <#T##((TVShowsModel.TVShowResponse) -> Void)##((TVShowsModel.TVShowResponse) -> Void)##(TVShowsModel.TVShowResponse) -> Void#>)
//    }
}
