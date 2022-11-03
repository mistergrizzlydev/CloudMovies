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
    var recentlySearchContainer: [String] = []
    var recentlySearch = UserDefaults.standard.stringArray(forKey: "recentlySearch") ?? [] {
        didSet {
            UserDefaults.standard.set(recentlySearch, forKey: "recentlySearch")
            UserDefaults.standard.synchronize()
        }
    }
    
    var currentPage = 0
    let totalPages = 4
    init(delegate: ViewModelProtocol) {
        self.delegate = delegate
    }
    func reload() {
        movies.removeAll()
        delegate?.updateView()
    }
    func getSearchResults(queryString: String) {
        currentPage += 1
        self.delegate?.showLoading()
        networkManager.getSearchedMovies(query: queryString, page: currentPage) { [weak self] response in
            guard let movies = response.results, !movies.isEmpty else {
                return
            }
            self?.movies.append(contentsOf: movies)
            self?.delegate?.updateView()
            self?.delegate?.hideLoading()
        }
    }
    func configureRecentlySearchContainer(title: String) {
        if recentlySearchContainer.count > 10 {
            recentlySearchContainer.removeFirst()
        }
        if !title.isEmpty == true {
            recentlySearchContainer.append(title)
            recentlySearch = recentlySearchContainer.unique().reversed()
        }
    }
}
