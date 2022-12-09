//
//  LocalState.swift
//  CloudMovies
//
//  Created by Артем Билый on 24.10.2022.
//

import Foundation

final class LocalState {
    private enum Keys: String {
        case hasOnboarded
    }
    static var hasOnboarded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
