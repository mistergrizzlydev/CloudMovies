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
    lazy var viewModel = WatchListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFullWatchList()
    }
    override func viewWillLayoutSubviews() {
        layout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    private func setupUI() {
        view.addSubview(tableView)
    }
    private func delegate() {
        tableView.register(WatchListCell.self, forCellReuseIdentifier: WatchListCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.delegate = self
    }
    private func layout() {
        tableView.frame = view.bounds
    }
}

extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sortedListMedia.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchListCell.cellIdentifier, for: indexPath) as? WatchListCell else { return UITableViewCell() }
        let media = viewModel.sortedListMedia[indexPath.row]
        cell.bindWithViewMedia(media: media)
        cell.delegate = self
        return cell
    }
}

extension WatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MovieDetailViewController()
        let media = viewModel.sortedListMedia[indexPath.row]
        //REMAKE IN FUTURE
        if media.title != nil {
            vc.tvShowId = media.id
        } else {
            vc.movieId = media.id
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension WatchListViewController: ViewModelProtocol {
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
