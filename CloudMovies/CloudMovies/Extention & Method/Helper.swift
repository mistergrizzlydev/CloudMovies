//
//  Helper.swift
//  CloudMovies
//
//  Created by Артем Билый on 26.10.2022.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func updateView()
    func showAlert()
    func reload()
    func addMedia()
    func deleteMedia()
}

extension ViewModelProtocol {
    func showLoading() { }
    func hideLoading() { }
    func updateView() { }
    func showAlert() { }
    func reload() { }
    func addMedia() { }
    func deleteMedia() { }
}

public enum MediaType: String {
    case movie = "movie"
    case tvShow = "tv"
}

public enum WatchListMediaType: String {
    case movies = "movies"
    case tvShow = "tv"
}

public enum MediaSection: String {
    case popular
    case topRated    = "top_rated"
    case nowPlaying  = "now_playing"
    case upcoming
    case onTheAir    = "on_the_air"
    case airingToday = "airing_today"
}

public enum MovieSection: String, CaseIterable {
    case onGoing = "Trending Movies"
    case upcoming = "Upcoming"
    case popular = "Fan favorites"
    case topRated = "Top rated"
    case popularTVShows = "Trending Serials"
    case topRatedTVShows = "Top rated Serials"
    case thisWeek = "Serials at this week"
    case newEpisodes = "Newest episodes"
}

public enum MovieSectionNumber: Int {
    case onGoing
    case popularTVShows
    case upcoming
    case popular
    case topRated
    case topRatedTVShows
    case thisWeek
    case newEpisodes
}
