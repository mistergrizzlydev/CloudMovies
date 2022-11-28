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
    private(set) var moviesList: [MediaModel.Media] = []
    private(set) var serialsList: [MediaModel.Media] = []
    // MARK: - Watchlist request
    func getFullWatchList() {
        delegate?.showLoading()
        if let accountID = StorageSecure.keychain["accountID"], let sessionID = StorageSecure.keychain["sessionID"] {
            networkManager.getWatchListMedia(accountID: accountID,
                                             sessionID: sessionID,
                                             mediaType: WatchListMediaType.movies.rawValue) { movies in
                DispatchQueue.main.async {
                    self.moviesList = movies.reversed()
                    self.delegate?.updateView()
                    self.delegate?.hideLoading()
                }
            }
            networkManager.getWatchListMedia(accountID: accountID,
                                             sessionID: sessionID,
                                             mediaType: WatchListMediaType.tvShow.rawValue) { tvShow in
                DispatchQueue.main.async {
                    self.serialsList = tvShow.reversed()
                    self.delegate?.updateView()
                    self.delegate?.hideLoading()
                }
            }
        }
    }
}
