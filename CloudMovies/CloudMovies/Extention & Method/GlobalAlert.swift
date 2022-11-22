//
//  GlobalAlert.swift
//  CloudMovies
//
//  Created by Артем Билый on 07.11.2022.
//

import UIKit

struct AlertCreator {
    private var accountID: Int {
        UserDefaults.standard.integer(forKey: "accountID")
    }
    private var sessionID: String {
        UserDefaults.standard.string(forKey: "sessionID") ?? ""
    }
    private var networkManager: NetworkService = {
        return NetworkService()
    }()
    func createAlert(mediaType: MediaType, mediaID: String) -> UIAlertController {
        let alert = UIAlertController(title: "Choose action",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Remove from Watchlist",
                                      style: .destructive) { [self]_ in
            networkManager.actionWatchList(mediaType: mediaType.rawValue,
                                           mediaID: mediaID,
                                           bool: false, accountID: String(accountID),
                                           sessionID: sessionID)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        return alert
    }
}
