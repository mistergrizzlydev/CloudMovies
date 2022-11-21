//
//  WatchListController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

final class WatchListViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.tableFooterView = UIView() // hide extra separator
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    private let loaderView = UIActivityIndicatorView()
    lazy var viewModel = WatchListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFullWatchList()
        loaderView.isHidden = true
    }
    override func viewWillLayoutSubviews() {
        layout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    private func setupUI() {
        view.addSubview(tableView)
        title = "Watchlist"
        navigationController?.navigationBar.prefersLargeTitles = true
        loaderView.color = .systemRed
        view.addSubview(loaderView)
        loaderView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
    }
    private func delegate() {
        tableView.register(WatchListCell.self, forCellReuseIdentifier: WatchListCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
    }
    private func layout() {
        tableView.frame = view.bounds
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.moviesList.count
        } else {
            return viewModel.serialsList.count
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && !viewModel.moviesList.isEmpty {
            return "Movies"
        } else if section == 1 && !viewModel.serialsList.isEmpty {
           return "Serials"
        } else {
            return ""
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchListCell.cellIdentifier, for: indexPath) as? WatchListCell else { return UITableViewCell() }
        cell.delegate = self
        switch indexPath.section {
        case 0:
            let media = viewModel.moviesList[indexPath.row]
            cell.bindWithViewMedia(media: media)
            return cell
        case 1:
            let media = viewModel.serialsList[indexPath.row]
            cell.bindWithViewMedia(media: media)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension WatchListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = MovieDetailViewController()
        switch indexPath.section {
        case 0:
            let media = viewModel.moviesList[indexPath.row]
            detailVC.movieId = media.id!
        case 1:
            let media = viewModel.serialsList[indexPath.row]
            detailVC.tvShowId = media.id!
        default:
            return
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension WatchListViewController: ViewModelProtocol {
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func showLoading() {
        loaderView.isHidden = false
        loaderView.startAnimating()
        view.bringSubviewToFront(loaderView)
    }
    func hideLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.loaderView.stopAnimating()
            self?.loaderView.isHidden = true
        }
    }
}
