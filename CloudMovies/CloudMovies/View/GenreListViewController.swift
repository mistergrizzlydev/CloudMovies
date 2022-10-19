//
//  GenreListController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

final class GenreListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fix later
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let authorizationVC = AuthorizationViewController()
            authorizationVC.modalPresentationStyle = .fullScreen
            self.present(authorizationVC, animated: true)
        }
    }
}
