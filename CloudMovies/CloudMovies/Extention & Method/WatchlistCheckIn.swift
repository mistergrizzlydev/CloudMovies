//
//  WatchlistCheckIn.swift
//  CloudMovies
//
//  Created by Artem Bilyi on 01.12.2022.
//

import Foundation

class CheckInWatchList {
    static let shared = CheckInWatchList()
    var mediaList: [MediaModel.Media] = []
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    func getFullWatchList() {
        mediaList.removeAll()
        if let accountID = StorageSecure.keychain["accountID"],
           let sessionID = StorageSecure.keychain["sessionID"] {
            networkManager.getWatchListMedia(accountID: accountID,
                                             sessionID: sessionID,
                                             mediaType: MediaType.movies.rawValue) { movies in
                DispatchQueue.main.async {
                    self.mediaList.append(contentsOf: movies)
                }
            }
            networkManager.getWatchListMedia(accountID: accountID,
                                             sessionID: sessionID,
                                             mediaType: MediaType.tvShow.rawValue) { tvShow in
                DispatchQueue.main.async {
                    self.mediaList.append(contentsOf: tvShow)
        
                }
            }
        }
    }
}
