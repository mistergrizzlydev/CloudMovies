//
//  RemoveDuplicates.swift
//  CloudMovies
//
//  Created by Артем Билый on 02.11.2022.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
