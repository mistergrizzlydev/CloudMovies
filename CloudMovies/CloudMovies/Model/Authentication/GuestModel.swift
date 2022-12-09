//
//  GuestModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 01.11.2022.
//

import Foundation

struct GuestModel: Decodable {
    let success: Bool?
    let guestSessionID: String?
    let expiresAt: String?
}
