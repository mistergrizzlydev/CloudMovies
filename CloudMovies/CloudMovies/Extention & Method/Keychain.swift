//
//  Keychain.swift
//  CloudMovies
//
//  Created by Artem Bilyi on 17.11.2022.
//

import Foundation
import KeychainAccess

//struct KeySecure {
//    static let shared = Keychain()
//    var sessionID: String {
//        KeySecure.shared["sessionID"]!
//    }
//}

// class KeychainContainer {
//    private enum Keys {
//        static let tokens = "tokens"
//    }
//
//    private let keychain: Keychain
//
//    init(service: String = Bundle.main.bundleIdentifier!) {
//        keychain = Keychain(service: service)
//            .synchronizable(false)
//            .accessibility(.afterFirstUnlock)
//    }
//
//    var tokens: SessionResponse? {
//        get {
//            read(key: Keys.tokens)
//        }
//        set {
//            guard let tokens = newValue else {
//                try? keychain.remove(Keys.tokens)
//                return
//            }
//
//            write(key: Keys.tokens, value: tokens)
//        }
//    }
//    // MARK: - Utils
//    private func read<T: Decodable>(key: String, type: T.Type = T.self) -> T? {
//        guard let data = try? keychain.getData(key) else { return nil }
//        do {
//            return try JSONDecoder().decode(type, from: data)
//        } catch {
//            print("KeychainContainer: Failed to decode \(type), \(error)")
//            return nil
//        }
//    }
//
//    private func write<T: Encodable>(key: String, value: T) {
//        guard let data = try? JSONEncoder().encode(value) else { return }
//        do {
//            try keychain.set(data, key: key)
//        } catch {
//            print("\(error)")
//        }
//    }
