//
//  WatchListViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 01.11.2022.
//

import Foundation

class WatchListViewModel {
    private(set) var listMovies: [MediaModel.Media] = []
    private(set) var tvShows: [MediaModel.MediaResponse] = []
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
        networkManager.getWatchListMedia(accountID: accountID, sessionID: sessionID, mediaType: WatchListMediaType.movies.rawValue) { movies in
            self.listMovies = movies
            print("LIST OF SAVED MOVIES \(self.listMovies)")
        }
    }
}
