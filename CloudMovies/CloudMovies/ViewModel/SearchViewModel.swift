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
    var recentlySearch: [String] = []
    var newSearch: [String] = []

    var currentPage = 0
    let totalPages = 10
    init(delegate: ViewModelProtocol) {
        self.delegate = delegate
    }
    func reload() {
        movies.removeAll()
        delegate?.updateView()
    }
    func getSearchResults(queryString: String) {
        currentPage += 1
        networkManager.getSearchedMovies(query: queryString, page: currentPage) { [weak self] response in
            guard let movies = response.results, !movies.isEmpty else {
                return
            }
            self?.movies.append(contentsOf: movies)
            self?.delegate?.updateView()
            self?.delegate?.hideLoading()
        }
    }
    func configureRecentlySearch(title: String) {
        self.recentlySearch.append(title)
    }
}
