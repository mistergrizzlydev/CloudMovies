//
//  SearchViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//
import UIKit

class SearchViewController: UIViewController {
    //MARK: - UI
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Filter by title text"
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()  //simple trick to hide extra separator lines
        tableView.rowHeight = 200
        return tableView
    }()
    
    private let loaderView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    lazy var viewModel = SearchViewModel(delegate: self)
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loaderView.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    //MARK: - delegate
    private func delegate() {
        tableView.register(SearchMovieCell.self, forCellReuseIdentifier: SearchMovieCell.cellIdentifier)
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
    }
    //MARK: - setupUI
    private func setup() {
        self.loaderView.center = self.view.center
        view.addSubview(tableView)
        view.addSubview(loaderView)
        navigationItem.titleView = searchBar
    }
    //MARK: - Request by query item
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            hideLoading()
            viewModel.flush()
            return
        }
        
        viewModel.getSearchResults(queryString: query.replacingOccurrences(of: " ", with: "+"))
    }
    //MARK: - hide keyboard by tap
//    private func setupDismissKeyboardGesture() {
//        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
//        view.addGestureRecognizer(dismissKeyboardTap)
//    }
//
//    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
//        view.endEditing(true)
//    }
}
//MARK: - UI updt
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
    }
}
//MARK: -
extension SearchViewController: UISearchBarDelegate, UITextFieldDelegate {
    //MARK: - search activie
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchBar) //throttling the search to improve performance
        perform(#selector(self.reload(_:)), with: searchBar, afterDelay: 0.5)
    }
    //MARK: - textfield Cancel Button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.flush()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - counting cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    //MARK: - cell configure
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieCell.cellIdentifier, for: indexPath) as! SearchMovieCell
        let movie = viewModel.movies[indexPath.row]
        cell.bindWithViewMovie(movie: movie)
        return cell
    }
    //MARK: - selected cell -> detailVC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchBar.searchTextField.endEditing(true)

        let movieDetail = MovieDetailViewController(movieId: viewModel.movies[indexPath.row].id)
        movieDetail.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(movieDetail, animated: true)
    }
}
