//
//  MovieDetailsViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 27.10.2022.
//

import UIKit

class MovieDetailsViewModel {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    weak var delegate: ViewModelProtocol?
    private(set) var currentMovie: MovieDetailsModel.MovieResponse?
    private(set) var currentTVShow: TVShowsDetailModel.TVShowResponse?
    private(set) var videosPath: [String] = []
    init(delegate: ViewModelProtocol) {
        self.delegate = delegate
    }
    func getMovieDetails(movieId: Int) {
        delegate?.showLoading()
        networkManager.getMovieDetails(movieId: movieId) { movie in
            DispatchQueue.main.async {
                self.currentMovie = movie
                self.delegate?.hideLoading()
                self.delegate?.updateView()
            }
        }
    }
    func getTVShowDetails(tvShowId: Int) {
        delegate?.showLoading()
        networkManager.getTVShowDetails(tvShowId: tvShowId) { tvShow in
            DispatchQueue.main.async {
                self.currentTVShow = tvShow
                self.delegate?.hideLoading()
                self.delegate?.updateView()
            }
        }
    }
    func getVideosMovies(movieID: Int) {
        delegate?.showLoading()
        networkManager.getVideos(mediaID: movieID, mediaType: MediaType.movie.rawValue) { [weak self] videos in
            DispatchQueue.main.async {
                self?.delegate?.hideLoading()
                let sorted = videos.filter { video in
                    return video.type == "Trailer"
                }
                for video in sorted {
                    self?.videosPath.append(video.key)
                }
                self?.delegate?.reload()
            }
        }
    }
    func getVideosTV(tvShowID: Int) {
        delegate?.showLoading()
        networkManager.getVideos(mediaID: tvShowID, mediaType: MediaType.tvShow.rawValue) { [weak self] videos in
            DispatchQueue.main.async {
                self?.delegate?.hideLoading()
                let sorted = videos.filter { video in
                    return video.type == "Trailer"
                }
                for video in sorted {
                    self?.videosPath.append(video.key)
                }
                self?.delegate?.reload()
            }
        }
    }
}
