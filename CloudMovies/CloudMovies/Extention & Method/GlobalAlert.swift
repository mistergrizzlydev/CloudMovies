//
//  GlobalAlert.swift
//  CloudMovies
//
//  Created by Артем Билый on 07.11.2022.
//

import UIKit

struct AlertCreator {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    func createAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Choose action",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Remove from Watchlist",
                                      style: .destructive) {_ in
        })
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel) {_ in
        })
        return alert
    }
}
