//
//  WatchListViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 01.11.2022.
//

import Foundation

class WatchListViewModel {
    private(set) var mediaList: [MediaModel.Media] = []
    private(set) var sortedListMedia: [MediaModel.Media] = []
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
        self.mediaList.removeAll()
        delegate?.showLoading()
        networkManager.getWatchListMedia(accountID: accountID, sessionID: sessionID, mediaType: WatchListMediaType.movies.rawValue) { movies in
            DispatchQueue.main.async {
                self.mediaList.append(contentsOf: movies)
                self.delegate?.updateView()
                self.delegate?.hideLoading()
            }
        }
        networkManager.getWatchListMedia(accountID: accountID, sessionID: sessionID, mediaType: WatchListMediaType.tvShow.rawValue) { tvShow in
            DispatchQueue.main.async {
                self.mediaList.append(contentsOf: tvShow)
                self.sortedListMedia = self.mediaList.sorted { $0.name ?? "" < $1.name ?? ""}
                self.delegate?.updateView()
                self.delegate?.hideLoading()
            }
        }
    }
}
