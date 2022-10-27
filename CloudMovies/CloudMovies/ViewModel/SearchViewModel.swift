//
//  ViewModel.swift
//
//  Created by Артем Билый on 27.10.2022.
//

import Foundation

class SearchViewModel {
    
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    
    private weak var delegate: ViewModelProtocol?
    private(set) var movies: [MoviesModel.Movie] = []
    
    init(delegate: ViewModelProtocol) {
        self.delegate = delegate
    }
    
    func flush() {
        movies.removeAll()
        delegate?.updateView()
    }
    
    func getSearchResults(queryString: String) {
        delegate?.showLoading()
        networkManager.getSearchedMovies(query: queryString) { movies in
            self.movies = movies.results
            self.delegate?.updateView()
        }
    }
}
