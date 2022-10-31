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
        let search = UISearchController()
        search.searchBar.placeholder = "Filter by title text"
        return search
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
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
    private let loaderView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
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
        // searchBar.searchResultUpdater
        searchController.searchBar.searchTextField.delegate = self
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
    }
    private func layout() {
        tableView.frame = view.bounds
        self.loaderView.center = self.view.center
        scrollUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollUpButton.widthAnchor.constraint(equalToConstant: 40),
            scrollUpButton.heightAnchor.constraint(equalToConstant: 40),
            scrollUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.height * 0.15)),
            scrollUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * 0.05))
        ])
    }
    @objc private func scrollUp() {
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
    }
    // MARK: - Request by query item
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            hideLoading()
            viewModel.reload()
            return
        }
        viewModel.reload()
        viewModel.getSearchResults(queryString: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    // dismiss keyboard by tap
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
// MARK: - UI updt
extension SearchViewController: ViewModelProtocol {
    func showLoading() {
        loaderView.isHidden = false
        loaderView.startAnimating()
        view.bringSubviewToFront(loaderView)
    }
    func hideLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.loaderView.stopAnimating()
            self?.loaderView.isHidden = true
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
}
//MARK: - SearchController Delegate
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
// MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    // MARK: search activie
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar) // throttling the search to improve performance
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
    }
    // MARK: textfield Cancel Button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.reload()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
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
        if (viewModel.currentPage != viewModel.totalPages) && (indexPath.row == viewModel.movies.count - 1) {
            guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
                hideLoading()
                viewModel.reload()
                return
            }
            viewModel.getSearchResults(queryString: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        }
    }
}
// MARK: - TableView Delegate
extension SearchViewController: UITableViewDelegate {
}
