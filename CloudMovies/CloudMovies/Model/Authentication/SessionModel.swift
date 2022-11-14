//
//  SessionModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 30.10.2022.
//

import Foundation

// MARK: - SessionResponse
struct SessionResponse: Codable {
    let success: Bool?
    let sessionID: String?
    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}
