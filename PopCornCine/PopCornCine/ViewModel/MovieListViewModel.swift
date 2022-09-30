//
//  PopularMovieListViewModel.swift
//  PopCornCine
//
//  Created by Артем Билый on 29.09.2022.
//

import Foundation

protocol MovieListViewModel: AnyObject {
    var movies: [Movie] { set get }
    var onFetchMovieSucceed: (() -> Void)? { set get }
    var onFetchMovieFailure: ((Error) -> Void)? { set get }
    func fetchMovie()
}

final class MovieListDefaultViewModel: MovieListViewModel {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    var movies: [Movie] = []
    var onFetchMovieSucceed: (() -> Void)?
    var onFetchMovieFailure: ((Error) -> Void)?
    
    func fetchMovie() {
        let request = MovieListRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies ?? []
                self?.onFetchMovieSucceed?()
            case .failure(let error):
                self?.onFetchMovieFailure?(error)
            }
        }
    }
}
