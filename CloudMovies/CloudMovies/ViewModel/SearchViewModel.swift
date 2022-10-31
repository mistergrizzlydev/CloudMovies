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
    var movies: [MoviesModel.Movie] = []
    private(set) var currentPage = 0
    var totalPages = 2
    init(delegate: ViewModelProtocol) {
        self.delegate = delegate
    }
    func reload() {
        movies.removeAll()
        delegate?.updateView()
    }
    func getSearchResults(queryString: String) {
        delegate?.showLoading()
        let page = currentPage + 1
        networkManager.getSearchedMovies(query: queryString, page: page) { response in
            guard let movies = response.results, !movies.isEmpty else {
                return
            }
            self.movies.append(contentsOf: movies)
            self.delegate?.updateView()
            self.delegate?.hideLoading()
        }
    }
}
