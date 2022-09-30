//
//  TabBarController.swift
//  PopCornCine
//
//  Created by Артем Билый on 28.09.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let viewModelMovie: MovieListViewModel = MovieListDefaultViewModel(networkService: DefaultNetworkService())
        let viewModelGenre: GenreListViewModel = GenreListDefaultViewModel(networkService: DefaultNetworkService())
        let genresViewController = createNavController(controller: GenresViewController(viewModelMovie: viewModelMovie, viewModelGenre: viewModelGenre), itemName: "Genres", itemImage: "text.append")
        let seachViewController = createNavController(controller: SearchViewController(), itemName: "Search", itemImage: "eyeglasses")
        let favouritesViewController = createNavController(controller: FavouritesViewController(), itemName: "Favourites", itemImage: "list.star")
        viewControllers = [genresViewController, seachViewController, favouritesViewController]
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
