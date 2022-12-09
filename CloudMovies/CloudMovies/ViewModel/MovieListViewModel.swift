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
    private(set) var topRated: [MediaResponse.Media] = []
    private(set) var onGoind: [MediaResponse.Media] = []
    private(set) var popular: [MediaResponse.Media] = []
    private(set) var upcoming: [MediaResponse.Media] = []
    private(set) var popularTVShows: [MediaResponse.Media] = []
    private(set) var topRatedTVShows: [MediaResponse.Media] = []
    private(set) var thisWeekTVShows: [MediaResponse.Media] = []
    private(set) var newEpisodes: [MediaResponse.Media] = []
    private(set) var sortedTVShow: [String: [MediaResponse.Media]] = [:]
    private(set) var sortedMovies: [String: [MediaResponse.Media]] = [:]
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
        networkManager.actionWatchList(mediaType: mediaType,
                                       mediaID: mediaID,
                                       bool: bool,
                                       accountID: accountID,
                                       sessionID: sessionID)
    }
}
