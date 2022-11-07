//
//  AccountModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 01.11.2022.
//

import Foundation

// MARK: - AccountModel
public struct AccountModel {
    // MARK: Account
    struct Account: Decodable {
        let id: Int?
        let name: String?
        let includeAdult: Bool?
        let username: String?
    }
}
