//
//  GuestModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 01.11.2022.
//

import Foundation
// MARK: - GuestModel
struct GuestModel: Codable {
    let success: Bool?
    let guestSessionID: String?
    let expiresAt: String?
    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionID = "guest_session_id"
        case expiresAt = "expires_at"
    }
}
