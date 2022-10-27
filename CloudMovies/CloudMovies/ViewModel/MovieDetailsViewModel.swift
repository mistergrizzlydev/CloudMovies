//
//  MovieDetailsViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 27.10.2022.
//

import UIKit

class MovieDetailsViewModel {
    
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    
    private weak var delegate: ViewModelProtocol?
    
    private(set) var currentMovie: MovieDetailsModel.MovieResponse?
    
    init(delegate: ViewModelProtocol) {
        self.delegate = delegate
    }
    
    func getMovieDetails(movieId: Int) {
        networkManager.getMovieDetails(movieId: movieId) { movie in
            DispatchQueue.main.async {
                self.currentMovie = movie
                self.delegate?.updateView()
            }
        }
    }
}
