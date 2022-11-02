//
//  SearchViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//
import UIKit

class SearchViewController: UIViewController {
    // MARK: - Init UI
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Filter by title text"
        return search
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.tableFooterView = UIView() // hide extra separator
        tableView.rowHeight = 200
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    private let scrollUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        let image = UIImage(named: "downarrow")
        button.setImage(image, for: .normal)
        return button
    }()
    private let loaderView = UIActivityIndicatorView()
    lazy var viewModel = SearchViewModel(delegate: self)
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        setup()
        setupDismissKeyboardGesture() // with empty page
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loaderView.isHidden = true
        scrollUpButton.isHidden = true
    }
    override func viewWillLayoutSubviews() {
        layout()
    }
    // MARK: - Delegate setup
    private func delegate() {
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.cellIdentifier)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.delegate = self
        searchController.searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        // searchBar.searchResultUpdater
        searchController.searchBar.searchTextField.delegate = self
    }
    func choose() {
        if searchController.showsSearchResultsController == false {
            print("default")
        } else {
            print("search")
        }
    }
    // MARK: - SetupUI
    private func setup() {
        scrollUpButton.addTarget(self, action: #selector(scrollUp), for: .touchUpInside)
        searchController.searchBar.keyboardType = .asciiCapable
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.autocapitalizationType = .sentences
        view.addSubview(tableView)
        view.addSubview(loaderView)
        view.addSubview(scrollUpButton)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true // doesnt work
        definesPresentationContext = true
        loaderView.color = .systemRed
    }
    private func layout() {
        tableView.frame = view.bounds
        scrollUpButton.translatesAutoresizingMaskIntoConstraints = false
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollUpButton.widthAnchor.constraint(equalToConstant: 40),
            scrollUpButton.heightAnchor.constraint(equalToConstant: 40),
            scrollUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.height * 0.15)),
            scrollUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * 0.05))
        ])
        NSLayoutConstraint.activate([
            loaderView.widthAnchor.constraint(equalToConstant: 50),
            loaderView.heightAnchor.constraint(equalToConstant: 50),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.height * 0.15)),
            loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * 0.05))
        ])
    }
    @objc private func scrollUp() {
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
    }
    
    func showSimpleAlert() {
        let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Sign out",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    // dismiss keyboard by tap
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        searchController.searchBar.endEditing(true)
    }
}
// MARK: - UI updt
extension SearchViewController: ViewModelProtocol {
    func showLoading() {
        scrollUpButton.isHidden = true
        loaderView.isHidden = false
        loaderView.startAnimating()
        view.bringSubviewToFront(loaderView)
    }
    func hideLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.loaderView.stopAnimating()
            self?.loaderView.isHidden = true
            self?.scrollUpButton.isHidden = false
        }
    }
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        if viewModel.movies.count > 1 {
            self.scrollUpButton.isHidden = false
        } else {
            self.scrollUpButton.isHidden = true
        }
    }
    func showAlert() {
        self.showSimpleAlert()
    }
}
//MARK: - SearchController Delegate
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            hideLoading()
            viewModel.reload()
            return
        }
        viewModel.reload()
        viewModel.currentPage = 0
        viewModel.getSearchResults(queryString: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
// MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    // MARK: textfield Cancel Button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.reload()
        self.scrollUpButton.isHidden = true //doesnt work
        searchBar.text = ""
            }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        viewModel.configureRecentlySearch(title: query)
        print(viewModel.recentlySearch)
        searchBar.resignFirstResponder()
    }
}
// MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
// MARK: - TableView DataSource
extension SearchViewController: UITableViewDataSource {
    // MARK: cell numbers in row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    // MARK: cell configure
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.cellIdentifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        let movie = viewModel.movies[indexPath.row]
        cell.bindWithViewMovie(movie: movie)
        cell.delegate = self
        return cell
    }
    // MARK: selected cell -> detailVC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchController.searchBar.searchTextField.endEditing(true)
        let movieDetail = MovieDetailViewController(movieId: viewModel.movies[indexPath.row].id)
        movieDetail.hidesBottomBarWhenPushed = true
        movieDetail.title = viewModel.movies[indexPath.row].title
        navigationController?.pushViewController(movieDetail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            hideLoading()
            viewModel.reload()
            return
        }
        if (viewModel.currentPage <= viewModel.totalPages) && (indexPath.row == viewModel.movies.count - 1) {
            self.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.viewModel.getSearchResults(queryString: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            }
        }
    }
}

// MARK: - TableView Delegate
extension SearchViewController: UITableViewDelegate {
}
