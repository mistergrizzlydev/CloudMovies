//
//  WatchListViewController.swift
//  PopCornCine
//
//  Created by Артем Билый on 28.09.2022.
//

import UIKit

class WatchListViewController: UIViewController {
    
    var array = ["Hello","Hello", "Hello", "Hello", "Hello", "Hello",
                 "Hello"]
    
    let searchController = UISearchController()
    
    private lazy var deleteItems: UIButton = {
        let signOutButton = UIButton.init(type: .system)
        signOutButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        signOutButton.setImage(UIImage(systemName: "trash"), for: .normal)
        return signOutButton
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.text = "Search this page"
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .grouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        setupUI()
        
    }
    override func viewDidLayoutSubviews() {
        setupTableViewConstraints()
    }
    
    private func delegate() {
        tableView.delegate = self
        tableView.dataSource = self
        searchController.delegate = self
        searchController.searchResultsUpdater = self
    }
    
    
    private func setupUI() {
        title = "Your watchlist"
        navigationItem.searchController = searchController
        let deleteItems = UIBarButtonItem(customView: deleteItems)
        navigationItem.rightBarButtonItems = [deleteItems]
        view.addSubview(tableView)
    }
    
    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension WatchListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
    }
}

extension WatchListViewController: UISearchControllerDelegate {
    
}

extension WatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] _, _, complition in
            tableView.beginUpdates()
            self?.array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            complition(true)
        }
        deleteAction.backgroundColor = .systemRed
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        configuration.text = array[indexPath.row]
        cell.contentConfiguration = configuration
        return cell
    }
}
