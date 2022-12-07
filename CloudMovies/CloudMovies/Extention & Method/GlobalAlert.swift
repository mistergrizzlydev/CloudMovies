//
//  GlobalAlert.swift
//  CloudMovies
//
//  Created by Артем Билый on 07.11.2022.
//

import UIKit

struct AlertCreator {

    private var networkManager: NetworkService = {
        return NetworkService()
    }()
    func createAlert(mediaType: String, mediaID: String, sender: UIButton) -> UIAlertController {
        let alert = UIAlertController(title: "Choose action",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Remove from Watchlist",
                                      style: .destructive) { [self]_ in
            if let sessionID = StorageSecure.keychain["sessionID"],
                let acccountID = StorageSecure.keychain["accountID"] {
                networkManager.actionWatchList(mediaType: mediaType,
                                               mediaID: mediaID,
                                               bool: false, accountID: acccountID,
                                               sessionID: sessionID)
                sender.isSelected.toggle()
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        return alert
    }
}
