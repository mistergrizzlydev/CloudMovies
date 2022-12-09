//
//  ViewModel.swift
//
//  Created by Артем Билый on 27.10.2022.
//

import Foundation

final class SearchViewModel {
    // MARK: - Network
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    weak var delegate: ViewModelProtocol?
    private(set) var media: [MediaResponse.Media] = []
    // MARK: Recently Search data
    var recentlySearchContainer: [String] = []
    var recentlySearch = UserDefaults.standard.stringArray(forKey: "recentlySearch") ?? [] {
        didSet {
            UserDefaults.standard.set(recentlySearch, forKey: "recentlySearch")
            UserDefaults.standard.synchronize()
        }
    }
    // MARK: Counter
    var currentPage = 0
    let totalPages = 4
    init(delegate: ViewModelProtocol) {
        self.delegate = delegate
    }
    // MARK: Remove && Update
    func reload() {
        media.removeAll()
        delegate?.updateView()
    }
    // MARK: - Requests
    func getSearchResultsMovies(queryString: String) {
        // Load more, paggination
        currentPage += 1
        self.delegate?.showLoading()
        networkManager.getSearchedMedia(query: queryString,
                                        page: currentPage,
                                        mediaType: MediaType.movie.rawValue) { [weak self] response in
            guard let movies = response.results, !movies.isEmpty else {
                return
            }
            self?.media.append(contentsOf: movies)
            self?.delegate?.updateView()
            self?.delegate?.hideLoading()
        }
    }
    func getSearchResultsTV(queryString: String) {
        currentPage += 1
        self.delegate?.showLoading()
        networkManager.getSearchedMedia(query: queryString,
                                        page: currentPage,
                                        mediaType: MediaType.tvShow.rawValue) { [weak self] response in
            guard let tvShows = response.results, !tvShows.isEmpty else {
                return
            }
            self?.media.append(contentsOf: tvShows)
            self?.delegate?.updateView()
            self?.delegate?.hideLoading()
        }
    }
    // MARK: - SearchController !isActive configure
    func configureRecentlySearchContainer(title: String) {
        // More than 10 > remove last
        if recentlySearchContainer.count > 10 {
            recentlySearchContainer.removeFirst()
        }
        // Remove Duplicates && reverse
        if !title.isEmpty == true {
            recentlySearchContainer.append(title)
            recentlySearch = recentlySearchContainer.unique().reversed()
        }
    }
}
