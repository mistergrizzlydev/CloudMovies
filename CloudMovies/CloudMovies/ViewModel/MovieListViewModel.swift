//
//  GenreList.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//
//

import Foundation

final class DiscoverViewModel {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    private(set) var topRated: [MediaModel.Media] = []
    private(set) var onGoind: [MediaModel.Media] = []
    private(set) var popular: [MediaModel.Media] = []
    private(set) var upcoming: [MediaModel.Media] = []
    private(set) var popularTVShows: [MediaModel.Media] = []
    private(set) var topRatedTVShows: [MediaModel.Media] = []
    private(set) var thisWeekTVShows: [MediaModel.Media] = []
    private(set) var newEpisodes: [MediaModel.Media] = []
    private(set) var sortedTVShow: [String: [MediaModel.Media]] = [:]
    private(set) var sortedMovies: [String: [MediaModel.Media]] = [:]
    weak var delegate: ViewModelProtocol?
    func getDiscoverScreen() {
        networkManager.getMediaList(mediaType: MediaType.movie.rawValue,
                                    sorted: MediaSection.popular.rawValue) { result in
            self.popular = result
        }
        networkManager.getMediaList(mediaType: MediaType.movie.rawValue,
                                    sorted: MediaSection.upcoming.rawValue) { result in
            self.upcoming = result
        }
        networkManager.getMediaList(mediaType: MediaType.movie.rawValue,
                                    sorted: MediaSection.topRated.rawValue) { result in
            self.topRated = result
        }
        networkManager.getMediaList(mediaType: MediaType.movie.rawValue,
                                    sorted: MediaSection.nowPlaying.rawValue) { result in
            self.onGoind = result
        }
        networkManager.getMediaList(mediaType: MediaType.tvShow.rawValue,
                                    sorted: MediaSection.popular.rawValue) { result in
            self.popularTVShows = result
        }
        networkManager.getMediaList(mediaType: MediaType.tvShow.rawValue,
                                    sorted: MediaSection.topRated.rawValue) { result in
            self.topRatedTVShows = result
        }
        networkManager.getMediaList(mediaType: MediaType.tvShow.rawValue,
                                    sorted: MediaSection.onTheAir.rawValue) { result in
            self.thisWeekTVShows = result
        }
        networkManager.getMediaList(mediaType: MediaType.tvShow.rawValue,
                                    sorted: MediaSection.airingToday.rawValue) { result in
            self.newEpisodes = result
        }
        self.delegate?.updateView()
    }
    func getSortedMovies() {
        networkManager.sortedMediaList(mediaType: MediaType.movie.rawValue) { movies in
            self.sortedMovies = movies
            self.delegate?.updateView()
        }
    }
    func getSortedTVShows() {
        networkManager.sortedMediaList(mediaType: MediaType.tvShow.rawValue) { tvShow in
            self.sortedTVShow = tvShow
            self.delegate?.updateView()
        }
    }
    func addMedia(mediaType: String, mediaID: String, bool: Bool, accountID: String, sessionID: String) {
        networkManager.actionWatchList(mediaType: mediaType, mediaID: mediaID, bool: bool, accountID: accountID, sessionID: sessionID)
    }
}
