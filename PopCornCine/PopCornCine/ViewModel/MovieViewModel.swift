//
//  PopularMovieViewModel.swift
//  PopCornCine
//
//  Created by Артем Билый on 29.09.2022.
//

import Foundation

protocol MovieViewModel {
    var movie: Movie { set get }
}

final class MovieDefaultViewModel: MovieViewModel {
    
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}
