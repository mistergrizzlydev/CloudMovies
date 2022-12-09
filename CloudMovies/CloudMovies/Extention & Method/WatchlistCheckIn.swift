//
//  WatchlistCheckIn.swift
//  CloudMovies
//
//  Created by Artem Bilyi on 01.12.2022.
//

import Foundation

final class CheckInWatchList {
    static let shared = CheckInWatchList()
    private(set) var movieList: [Int] = []
    private(set) var tvShowList: [Int] = []
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    func getMoviesID(completion: () -> Void) {
        var idMovieNumbers: [Int] = []
        if let accountID = StorageSecure.keychain["accountID"],
           let sessionID = StorageSecure.keychain["sessionID"] {
            networkManager.getWatchListMedia(accountID: accountID,
                                             sessionID: sessionID,
                                             mediaType: MediaType.movies.rawValue) { movies in
                DispatchQueue.main.async {
                    for movie in movies {
                        if let id = movie.id {
                            idMovieNumbers.append(id)
                        }
                    }
                    self.movieList = idMovieNumbers
                }
            }
        }
    }
    func getTVShowsID(completion: () -> Void) {
        var idTVNumbers: [Int] = []
        if let accountID = StorageSecure.keychain["accountID"],
           let sessionID = StorageSecure.keychain["sessionID"] {
            networkManager.getWatchListMedia(accountID: accountID,
                                             sessionID: sessionID,
                                             mediaType: MediaType.tvShow.rawValue) { movies in
                DispatchQueue.main.async {
                    for movie in movies {
                        if let id = movie.id {
                            idTVNumbers.append(id)
                        }
                    }
                    self.tvShowList = idTVNumbers
                }
            }
        }
    }
}
