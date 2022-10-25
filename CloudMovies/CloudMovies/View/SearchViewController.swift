//
//  SearchViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
//        searchBar.showsCancelButton = true
        searchBar.placeholder = "Filter by title text"
        return searchBar
    }()
    private let loader = UIActivityIndicatorView()
    private let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        setupUI()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loader.isHidden = true
    }
    
    private func delegate() {
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
    }
    
    private func setupUI() {

        navigationItem.titleView = searchBar
    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
}
