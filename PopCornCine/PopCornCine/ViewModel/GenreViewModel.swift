//
//  GenreViewModel.swift
//  PopCornCine
//
//  Created by Артем Билый on 30.09.2022.
//

import Foundation

protocol GenreViewModel {
    var genre: Genre { set get }
}

final class GenreDefaultViewModel: GenreViewModel {
    
    var genre: Genre
    
    init(genre: Genre) {
        self.genre = genre
    }
}
