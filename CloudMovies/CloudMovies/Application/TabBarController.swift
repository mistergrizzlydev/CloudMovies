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
        let movieListViewModel: MovieListViewModel = MovieListDefaultViewModel()
        let genreListController = createNavController(controller: MovieListViewController(movieListViewModel: movieListViewModel), itemName: "Popular", itemImage: "text.append")
        let seachController = createNavController(controller: SearchViewController(), itemName: "Search", itemImage: "eyeglasses")
        let watchListController = createNavController(controller: WatchListViewController(), itemName: "Watchlist", itemImage: "list.star")
        viewControllers = [genreListController, seachController, watchListController]
    }
    
    func createNavController(controller: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        let navigationController = UINavigationController(rootViewController: controller)
        navigationController.tabBarItem = item
        controller.view.backgroundColor = .white
        navigationController.view.backgroundColor = .white
        return navigationController
    }
}
