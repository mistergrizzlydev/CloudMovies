//
//  WatchlistCheckIn.swift
//  CloudMovies
//
//  Created by Artem Bilyi on 01.12.2022.
//

import Foundation

class CheckInWatchList {
    static let shared = CheckInWatchList()
    var movieList: [Int] = []
    var tvShowList: [Int] = []
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    func getMoviesID(completion: @escaping ([Int]) -> ()) {
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
                    completion(idMovieNumbers)
                }
            }
        }
    }
    func getTVShowsID(completion: @escaping ([Int]) -> ()) {
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
                    completion(idTVNumbers)
                }
            }
        }
    }
}
