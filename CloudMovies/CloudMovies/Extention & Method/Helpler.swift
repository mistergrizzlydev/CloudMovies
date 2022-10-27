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
    func showError(message: String)
}

extension ViewModelProtocol {
    func showLoading() { }
    func hideLoading() { }
    func updateView() { }
    func showError(message: String) { }
}

public enum MediaType: String {
    case movie
    case tv
}

public enum MediaSection: String {
    case popular
    case topRated   = "top_rated"
    case nowPlaying = "now_playing"
    case upcoming
    
}
