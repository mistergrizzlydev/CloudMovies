//
//  GuestModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 01.11.2022.
//

import Foundation

public struct GuestModel: Codable {
    public let success: Bool?
    public let guestSessionID: String?
    public let expiresAt: String?
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case guestSessionID = "guest_session_id"
        case expiresAt = "expires_at"
    }
}
