//
//  TabBarController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.tabBar.isTranslucent = true
    }
    func setupTabBar() {
        let movieListController = createNavController(controller: DiscoverViewController(), item: "Popular", image: "text.append")
        let seachController = createNavController(controller: SearchViewController(), item: "Search", image: "eyeglasses")
        let watchListController = createNavController(controller: WatchListViewController(), item: "Watchlist", image: "list.star")
        viewControllers = [movieListController, seachController, watchListController]
    }
    func createNavController(controller: UIViewController, item: String, image: String) -> UINavigationController {
        let item = UITabBarItem(title: item, image: UIImage(systemName: image)?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem = item
        controller.view.backgroundColor = .white
        navigationController.view.backgroundColor = .white
        return navigationController
    }
}
