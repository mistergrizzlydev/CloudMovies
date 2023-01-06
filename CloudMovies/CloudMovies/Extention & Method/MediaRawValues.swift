//
//  Helper.swift
//  CloudMovies
//
//  Created by Артем Билый on 26.10.2022.
//

import Foundation

struct Constants {
    static let apiKey = "b3187cf196a7681dee8805cdcec0d6ba"
    static let mainURL = "https://api.themoviedb.org/3/"
    static let signUpURL = "https://www.themoviedb.org/signup"
    static let forgetPasswordURL = "https://www.themoviedb.org/reset-password"
    static let linkURL = "https://www.linkedin.com/in/alexandr-slobodianiuk/"
    static let auth = "authentication/"
}

enum MediaType: String {
    case movie = "movie"
    case tvShow = "tv"
    case movies = "movies"
}
enum MediaSection: String {
    case popular
    case topRated = "top_rated"
    case nowPlaying = "now_playing"
    case upcoming
    case onTheAir = "on_the_air"
    case airingToday = "airing_today"
}

enum MovieSection: String, CaseIterable {
    case onGoing = "Trending Movies"
    case upcoming = "Upcoming"
    case popular = "Fan favorites"
    case topRated = "Top rated"
    case popularTVShows = "Trending TV Shows"
    case topRatedTVShows = "Top rated TV Shows"
    case thisWeek = "TV Shows at this week"
    case newEpisodes = "Newest episodes"
}

enum MovieSectionNumber: Int {
    case onGoing
    case popularTVShows
    case upcoming
    case popular
    case topRated
    case topRatedTVShows
    case thisWeek
    case newEpisodes
}
