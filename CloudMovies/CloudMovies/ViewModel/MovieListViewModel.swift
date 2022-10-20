//
//  MoviesListViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//

import Foundation

protocol MovieListViewModel: AnyObject {
    var movies: [Movie] { set get }
    var onFetchMovieSucceed: (() -> Void)? { set get }
    var onFetchMovieFailure: ((Error) -> Void)? { set get }
    func fetchMovie()
}

class MovieListDefaultViewModel: MovieListViewModel {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    var movies: [Movie] = []
    var onFetchMovieSucceed: (() -> Void)?
    var onFetchMovieFailure: ((Error) -> Void)?
    
    func fetchMovie() {
        let request = MovieRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.onFetchMovieSucceed?()
            case .failure(let error):
                self?.onFetchMovieFailure?(error)
            }
        }
    }
}
