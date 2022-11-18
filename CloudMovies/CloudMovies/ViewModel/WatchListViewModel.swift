//
//  WatchListViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 01.11.2022.
//

import Foundation

class WatchListViewModel {
    private(set) var moviesList: [MediaModel.Media] = []
    private(set) var serialsList: [MediaModel.Media] = []
    weak var delegate: ViewModelProtocol?
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    private var accountID: Int {
        UserDefaults.standard.integer(forKey: "accountID")
    }
    private var sessionID: String {
        UserDefaults.standard.string(forKey: "sessionID") ?? ""
    }
    func getFullWatchList() {
        delegate?.showLoading()
        networkManager.getWatchListMedia(accountID: accountID, sessionID: sessionID, mediaType: WatchListMediaType.movies.rawValue) { movies in
            DispatchQueue.main.async {
                self.moviesList = movies
                self.delegate?.updateView()
                self.delegate?.hideLoading()
            }
        }
        networkManager.getWatchListMedia(accountID: accountID, sessionID: sessionID, mediaType: WatchListMediaType.tvShow.rawValue) { tvShow in
            DispatchQueue.main.async {
                self.serialsList = tvShow
                self.delegate?.updateView()
                self.delegate?.hideLoading()
            }
        }
    }
}
