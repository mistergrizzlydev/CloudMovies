//
//  WatchListViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 01.11.2022.
//

import Foundation

final class WatchListViewModel {
    // MARK: - Network
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    weak var delegate: ViewModelProtocol?
    // MARK: - Data
    private(set) var moviesList: [MediaResponse.Media] = []
    private(set) var serialsList: [MediaResponse.Media] = []
    // MARK: - Watchlist request
    func getFullWatchList() {
        if StorageSecure.keychain["guestID"] != nil {
            serialsList.removeAll()
            moviesList.removeAll()
            self.delegate?.updateView()
        }
        if let accountID = StorageSecure.keychain["accountID"],
           let sessionID = StorageSecure.keychain["sessionID"] {
            networkManager.getWatchListMedia(accountID: accountID,
                                             sessionID: sessionID,
                                             mediaType: MediaType.movies.rawValue) { movies in
                DispatchQueue.main.async {
                    self.moviesList = movies.reversed()
                    self.delegate?.updateView()
                    self.delegate?.hideLoading()
                }
            }
            networkManager.getWatchListMedia(accountID: accountID,
                                             sessionID: sessionID,
                                             mediaType: MediaType.tvShow.rawValue) { tvShow in
                DispatchQueue.main.async {
                    self.serialsList = tvShow.reversed()
                    self.delegate?.updateView()
                    self.delegate?.hideLoading()
                }
            }
        }
    }
}
