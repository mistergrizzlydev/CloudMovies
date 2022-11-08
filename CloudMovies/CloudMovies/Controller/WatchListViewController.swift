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
    var movieCounter = 0
    var tvShowCounter = 0
    lazy var viewModel = WatchListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.getFullWatchList()
        delegate()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFullWatchList()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                    self.tableView.reloadData()
//                }
    }
    override func viewWillLayoutSubviews() {
        layout()
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
        print("Total Count:\(viewModel.tvShows.count + viewModel.listMovies.count)")
        return viewModel.listMovies.count + viewModel.tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchListCell.cellIdentifier, for: indexPath) as? WatchListCell else { return UITableViewCell() }
        cell.delegate = self
        if indexPath.row % 2 == 0 {
            print("LIST MOVIES \(viewModel.listMovies.count)")
            if movieCounter != viewModel.listMovies.count {
                let movie = viewModel.listMovies[movieCounter]
                movieCounter += 1
                cell.bindWithViewMedia(media: movie)
            } else if tvShowCounter != viewModel.tvShows.count {
                let movie = viewModel.tvShows[tvShowCounter]
                tvShowCounter += 1
                cell.bindWithViewMedia(media: movie)
            }
            return cell
        } else {
            print("LIST TV SHOWS \(viewModel.tvShows.count)")
            if tvShowCounter != viewModel.tvShows.count {
                let movie = viewModel.tvShows[tvShowCounter]
                tvShowCounter += 1
                cell.bindWithViewMedia(media: movie)
            } else if movieCounter != viewModel.listMovies.count {
                let movie = viewModel.listMovies[movieCounter]
                movieCounter += 1
                cell.bindWithViewMedia(media: movie)
            }
            return cell
        }
    }
}

extension WatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension WatchListViewController: ViewModelProtocol {
    func updateView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
