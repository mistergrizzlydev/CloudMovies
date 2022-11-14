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
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
