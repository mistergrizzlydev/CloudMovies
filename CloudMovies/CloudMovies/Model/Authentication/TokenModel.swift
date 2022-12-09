//
//  TokenModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 29.10.2022.
//

import Foundation

// MARK: - TokenResponse
struct TokenResponse: Codable {
    let success: Bool?
    let expiresAt, requestToken: String?
    let statusCode: Int?
    let statusMessage: String?
}
