//
//  GenreList.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//
//

import Foundation

protocol GenreListViewModel: AnyObject {
    var genres: [Genre] { set get }
    var onFetchGenresSucceed: (() -> Void)? { set get }
    var onFetchGenresFailure: ((Error) -> Void)? { set get }
    func fetchGenres()
}

final class GenreListDefaultViewModel: GenreListViewModel {

    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    var genres: [Genre] = []
    var onFetchGenresSucceed: (() -> Void)?
    var onFetchGenresFailure: ((Error) -> Void)?
    
    func fetchGenres() {
        let request = GenreListRequest()
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let genres):
                self?.genres = genres ?? []
                self?.onFetchGenresSucceed?()
            case .failure(let error):
                self?.onFetchGenresFailure?(error)
            }
        }
    }
}
