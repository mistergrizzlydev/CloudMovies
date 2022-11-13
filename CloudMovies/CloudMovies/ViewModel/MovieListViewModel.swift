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
    private(set) var topRated:               [MediaModel.Media] = []
    private(set) var onGoind:                [MediaModel.Media] = []
    private(set) var popular:                [MediaModel.Media] = []
    private(set) var upcoming:               [MediaModel.Media] = []
    private(set) var popularTVShows:         [MediaModel.Media] = []
    private(set) var topRatedTVShows:        [MediaModel.Media] = []
    private(set) var thisWeekTVShows:        [MediaModel.Media] = []
    private(set) var newEpisodes:            [MediaModel.Media] = []
    private(set) var sortedTVShow: [String: [MediaModel.Media]] = [:]
    private(set) var sortedMovies: [String: [MediaModel.Media]] = [:]
    weak var delegate: ViewModelProtocol?
    func getDiscoverScreen() {
        networkManager.getPopularMovies { result in
            self.popular = result
        }
        networkManager.getUpcomingMovies { result in
            self.upcoming = result
        }
        networkManager.getTopRatedMovies { result in
            self.topRated = result
        }
        networkManager.getNowPlayingMovies { result in
            self.onGoind = result
        }
        networkManager.getPopularTVShows { result in
            self.popularTVShows = result
        }
        networkManager.getTopRatedTVShows { result in
            self.topRatedTVShows = result
        }
        networkManager.getThisWeek { result in
            self.thisWeekTVShows = result
        }
        networkManager.getNewEpisodes { result in
            self.newEpisodes = result
        }
        self.delegate?.updateView()
    }
    func getSortedMovies() {
        networkManager.sortedMovies { movies in
            self.sortedMovies = movies
            self.delegate?.updateView()
        }
    }
    func getSortedTVShows() {
        networkManager.sortedTVShows { tvShow in
            self.sortedTVShow = tvShow
            self.delegate?.updateView()
        }
    }
    func addMedia(mediaType: String, mediaID: String, bool: Bool, accountID: String, sessionID: String)  {
        networkManager.actionWatchList(mediaType: mediaType, mediaID: mediaID, bool: bool, accountID: accountID, sessionID: sessionID)
    }
}
