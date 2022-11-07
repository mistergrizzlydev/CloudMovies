//
//  GlobalAlert.swift
//  CloudMovies
//
//  Created by Артем Билый on 07.11.2022.
//

import UIKit

func bottomAlert() -> UIAlertController {
    let alert = UIAlertController(title: "Choose action", message: nil, preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Remove from Watchlist", style: .destructive, handler: { action in
        
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
    }))
    return alert
}
