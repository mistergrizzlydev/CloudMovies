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
    func createAlert(mediaType: String, mediaID: String) -> UIAlertController {
        let alert = UIAlertController(title: "Choose action",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Remove from Watchlist",
                                      style: .destructive) { [self]_ in
            self.networkManager.actionWatchList(mediaType: mediaType, mediaID: mediaType, bool: false, accountID: String(accountID), sessionID: sessionID)
        })
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel) {_ in
        })
        return alert
    }
}
