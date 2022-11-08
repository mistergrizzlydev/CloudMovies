//
//  WatchListViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 01.11.2022.
//

import Foundation

class WatchListViewModel {
    private(set) var listMovies: [MediaModel.Media] = []
    private(set) var tvShows: [MediaModel.Media] = []
    weak var delegate: ViewModelProtocol?
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    private var accountID: Int {
        get {
            UserDefaults.standard.integer(forKey: "accountID")
        }
    }
    private var sessionID: String {
        get {
            UserDefaults.standard.string(forKey: "sessionID") ?? ""
        }
    }
    func getFullWatchList() {
        delegate?.showLoading()
        networkManager.getWatchListMedia(accountID: accountID, sessionID: sessionID, mediaType: WatchListMediaType.movies.rawValue) { movies in
            DispatchQueue.main.async {
                self.listMovies = movies
                self.delegate?.updateView()
                self.delegate?.hideLoading()
            }
        }
        networkManager.getWatchListMedia(accountID: accountID, sessionID: sessionID, mediaType: WatchListMediaType.tvShow.rawValue) { tvShow in
            DispatchQueue.main.async {
                self.tvShows = tvShow
                self.delegate?.updateView()
                self.delegate?.hideLoading()
            }
        }
    }
}
