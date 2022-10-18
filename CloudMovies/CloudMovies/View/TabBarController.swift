//
//  TabBarController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    @IBOutlet var loginController: AuthorizationViewController!
    
    override func viewDidLoad() {
        loginController.modalPresentationStyle = .fullScreen
//        self.present(loginController, animated: true)
        setupTabBar()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func setupTabBar() {
        let genreListController = createNavController(controller: GenreListViewController(), itemName: "Genres", itemImage: "text.append")
        let seachController = createNavController(controller: SearchViewController(), itemName: "Search", itemImage: "eyeglasses")
        let watchListController = createNavController(controller: WatchListViewController(), itemName: "Watchlist", itemImage: "list.star")
        viewControllers = [genreListController, seachController, watchListController]
    }
    
    func createNavController(controller: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        let navigationController = UINavigationController(rootViewController: controller)
        controller.view.backgroundColor = .white
        navigationController.tabBarItem = item
        return navigationController
    }
}
