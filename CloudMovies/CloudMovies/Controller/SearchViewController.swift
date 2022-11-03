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
    private let noRecentLabel: UILabel = {
        let noRecentLabel = UILabel()
        noRecentLabel.text = "No Recent Search"
        noRecentLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        noRecentLabel.textAlignment = NSTextAlignment.center
        return noRecentLabel
    }()
    private let clearAll = UIButton(type: .system)
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "recentlyCell")
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.delegate = self
        searchController.searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        searchController.searchBar.searchTextField.delegate = self
    }
    // MARK: - SetupUI
    private func setup() {
        scrollUpButton.addTarget(self, action: #selector(scrollUp), for: .touchUpInside)
        searchController.searchBar.keyboardType = .asciiCapable
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.autocapitalizationType = .sentences
        searchController.hidesNavigationBarDuringPresentation = false
        view.addSubview(tableView)
        view.addSubview(loaderView)
        view.addSubview(scrollUpButton)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false // doesnt work
        definesPresentationContext = true
        loaderView.color = .systemRed
        noRecentLabel.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
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
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    // dismiss keyboard by tap
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
        searchController.searchBar.endEditing(true)
        recognizer.cancelsTouchesInView = false
    }
    @objc func resetResults() {
        viewModel.recentlySearchContainer.removeAll()
        viewModel.recentlySearch.removeAll()
        updateView()
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
        if viewModel.movies.count == 0 {
            self.scrollUpButton.isHidden = true
        } else {
            self.scrollUpButton.isHidden = false
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    func showAlert() {
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
        self.scrollUpButton.isHidden = true // doesnt work
        searchBar.text = ""
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        searchBar.resignFirstResponder()
        viewModel.configureRecentlySearchContainer(title: query)
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch searchController.isActive {
        case true:
            return UIView()
        case false:
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height / 2))
            clearAll.frame = CGRect(x: tableView.frame.maxX * 0.79, y: 10, width: 100, height: 15)
            clearAll.setTitle("Clear", for: .normal)
            clearAll.setTitleColor(.systemGray, for: .normal)
            clearAll.addTarget(self, action: #selector(resetResults), for: .touchUpInside)
            headerView.addSubview(clearAll)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    // MARK: cell numbers in row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchController.isActive {
        case true:
            self.scrollUpButton.isHidden = false
            return viewModel.movies.count
        case false:
            if viewModel.recentlySearch.count == 0 {
                self.clearAll.isHidden = true
                self.tableView.backgroundView = noRecentLabel
                self.noRecentLabel.isHidden = false
            } else {
                self.clearAll.isHidden = false
                self.noRecentLabel.isHidden = true
            }
            return viewModel.recentlySearch.count
        }
    }
    // MARK: cell configure
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchController.isActive {
        case true:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.cellIdentifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
            let movie = viewModel.movies[indexPath.row]
            cell.bindWithViewMovie(movie: movie)
            cell.delegate = self
            return cell
        case false:
            let recentlySearchCell = tableView.dequeueReusableCell(withIdentifier: "recentlyCell", for: indexPath)
            recentlySearchCell.textLabel?.text = viewModel.recentlySearch[indexPath.row]
            return recentlySearchCell
        }
    }
    // MARK: selected cell -> detailVC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchController.searchBar.searchTextField.endEditing(true)
        switch searchController.isActive {
        case true:
            return print("Init Detail")
        case false:
            viewModel.reload()
            viewModel.currentPage = 0
            self.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.searchController.searchBar.text = self.viewModel.recentlySearch[indexPath.row]
                self.viewModel.getSearchResults(queryString: self.searchController.searchBar.text ?? "")
                self.searchController.isActive = true
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        switch searchController.isActive {
        case true:
            if (viewModel.currentPage <= viewModel.totalPages) && (indexPath.row == viewModel.movies.count - 1) {
                self.showLoading()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.viewModel.getSearchResults(queryString: query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
                }
            }
        case false:
            return
        }
    }
}
// MARK: - TableView Delegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchController.isActive == false {
            return 35.0
        } else {
            return 200.0
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch searchController.isActive {
        case true:
            return UISwipeActionsConfiguration()
        case false:
            let deleteButton = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
                tableView.beginUpdates()
                self.viewModel.recentlySearch.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
            deleteButton.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteButton])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
    }
}