//
//  SessionModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 30.10.2022.
//

import Foundation

// MARK: - SessionResponse
struct SessionResponse: Decodable {
    let success: Bool?
    let sessionID: String?
}
