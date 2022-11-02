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
        //        let avatar: Avatar?
        let id: Int?
        //        let iso639_1: String?
        //        let iso3166_1: String?
        let name: String?
        let includeAdult: Bool?
        let username: String?
    }
    // MARK: Avatar
    //    struct Avatar: Decodable {
    //        let gravatar: Gravatar?
    //        let tmdb: Tmdb?
    //    }
    //    // MARK: Gravatar
    //    struct Gravatar: Decodable {
    //        let hash: String?
    //    }
    // MARK: Tmdb
    //    struct Tmdb: Codable {
    //        let avatarPath: NSNull?
    //
    //        enum CodingKeys: String, CodingKey {
    //            case avatarPath = "avatar_path"
    //        }
    //    }
}
