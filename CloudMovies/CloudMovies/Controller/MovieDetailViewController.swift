//
//  MovieDetailController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    
    private let posterImage = UIImageView()
    private let contrainer = UIView()
    private let titleLabel = UILabel()
    private let date = UILabel()
    private let genres = UILabel()
    private let overview = UILabel()
    private let subtitleLabel = UILabel()
    private var genresName = [String]()
    private let watchListButton = UIButton(type: .system)
    private let loaderView = UIActivityIndicatorView()
    private lazy var viewModel = MovieDetailsViewModel(delegate: self)
    private let dots = UIPageControl()
    private lazy var videoCollectionView: UICollectionView = {
        let videoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createVideoLayout())
        videoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        videoCollectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifier)
        return videoCollectionView
    }()
    var movieId: Int = 0
    var tvShowId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        selectData()
        setTitle()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieId = 0
        tvShowId = 0
        genresName = []
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func setupUI() {
        viewModel.delegate = self
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        view.backgroundColor = .white
        contrainer.clipsToBounds = true
        contrainer.contentMode = .scaleAspectFill
        contrainer.backgroundColor = .white
        contrainer.layer.cornerRadius = 8
        contrainer.translatesAutoresizingMaskIntoConstraints = false
        contrainer.dropShadow()
        // Label
        titleLabel.backgroundColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        // Image View
        posterImage.clipsToBounds = true
        posterImage.backgroundColor = .white
        posterImage.contentMode = .scaleAspectFill
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        // date
        date.backgroundColor = .white
        date.numberOfLines = 1
        date.font = UIFont.systemFont(ofSize: 14, weight: .light)
        date.textAlignment = .left
        date.textColor = .black
        date.translatesAutoresizingMaskIntoConstraints = false
        // genres
        genres.backgroundColor = .white
        genres.numberOfLines = 0
        genres.font = UIFont.systemFont(ofSize: 14, weight: .light)
        genres.textAlignment = .left
        genres.textColor = .black
        genres.translatesAutoresizingMaskIntoConstraints = false
        // Overview
        overview.backgroundColor = .white
        overview.textColor = .black
        //        overview.textAlignment =
        overview.numberOfLines = 0
        overview.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        overview.translatesAutoresizingMaskIntoConstraints = false
        // WatchListButton
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .small
        config.titleAlignment = .leading
        //        config.title = "Add to Watchlist"
        config.background.backgroundColor = .systemRed
        watchListButton.translatesAutoresizingMaskIntoConstraints = false
        watchListButton.setTitle("Add to Watchlist", for: [])
        watchListButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.leading
        watchListButton.setTitleColor(.white, for: .normal)
        watchListButton.configuration = config
        watchListButton.dropShadow()
        //        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        loaderView.color = .systemRed
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        dots.pageIndicatorTintColor = .lightGray
        dots.currentPageIndicatorTintColor = .black
        dots.isUserInteractionEnabled = false
        dots.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contrainer)
        view.addSubview(titleLabel)
        contrainer.addSubview(posterImage)
        view.addSubview(date)
        view.addSubview(genres)
        view.addSubview(overview)
        view.addSubview(watchListButton)
        view.addSubview(loaderView)
        view.addSubview(videoCollectionView)
        view.addSubview(dots)
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            contrainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            contrainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contrainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            contrainer.heightAnchor.constraint(equalTo: contrainer.widthAnchor, multiplier: 1.5)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            posterImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            posterImage.heightAnchor.constraint(equalTo: posterImage.widthAnchor, multiplier: 1.5)
        ])
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            date.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            date.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            genres.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 8),
            genres.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            genres.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: genres.bottomAnchor),
            overview.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            overview.bottomAnchor.constraint(equalTo: posterImage.bottomAnchor),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            watchListButton.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 24),
            watchListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            watchListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            watchListButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: watchListButton.bottomAnchor, constant: 80),
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.widthAnchor.constraint(equalToConstant: 100),
            loaderView.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            videoCollectionView.topAnchor.constraint(equalTo: watchListButton.bottomAnchor, constant: 24),
            videoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoCollectionView.heightAnchor.constraint(equalTo: videoCollectionView.widthAnchor, multiplier: 0.5625)
        ])
        NSLayoutConstraint.activate([
            dots.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dots.topAnchor.constraint(equalTo: videoCollectionView.bottomAnchor, constant: 8)
        ])
    }
    private func selectData() {
        if movieId != 0 {
            viewModel.getVideosMovies(movieID: movieId)
            viewModel.getMovieDetails(movieId: movieId)
        } else {
            viewModel.getVideosTV(tvShowID: tvShowId)
            viewModel.getTVShowDetails(tvShowId: tvShowId)
        }
    }
    private func setTitle() {
        if movieId != 0 {
            navigationItem.title = viewModel.currentMovie?.title
        } else {
            navigationItem.title = viewModel.currentTVShow?.name
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        dots.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        dots.currentPage = indexPath.row
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell else {
            return UICollectionViewCell()
        }
        cell.bindWithMedia(keysPath: viewModel.videosPath, index: indexPath.item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.videosPath.count
        if count == 1 {
            dots.numberOfPages = 0
        } else {
            dots.numberOfPages = viewModel.videosPath.count
        }
        return count
    }
}
extension MovieDetailViewController: ViewModelProtocol {
    func reload() {
        self.videoCollectionView.reloadData()
    }
    func showLoading() {
        loaderView.isHidden = false
        loaderView.startAnimating()
        view.bringSubviewToFront(loaderView)
    }
    func hideLoading() {
        loaderView.isHidden = true
        loaderView.stopAnimating()
    }
    func updateView() {
        if movieId != 0 {
            guard let movie = viewModel.currentMovie else { return }
            self.navigationItem.title = movie.title ?? ""
            let url = URL(string: "https://image.tmdb.org/t/p/w780\(movie.posterPath ?? "")")
            posterImage.kf.setImage(with: url)
            titleLabel.text = (movie.title ?? movie.originalTitle ?? "")
            date.text = movie.releaseDate
            overview.text = movie.overview
            genresName.removeAll()
            guard let genresResponse = movie.genres else { return }
            var genresList = ""
            for genre in genresResponse {
                genresList += (genre.name ?? "") + "\n"
            }
            genres.text = genresList
        } else {
            guard let tvShow = viewModel.currentTVShow else { return }
            self.navigationItem.title = tvShow.name
            let url = URL(string: "https://image.tmdb.org/t/p/w780\(tvShow.posterPath ?? "")")
            posterImage.kf.setImage(with: url)
            titleLabel.text = tvShow.name
            date.text = tvShow.firstAirDate
            overview.text = tvShow.overview
            genresName.removeAll()
            guard let genresResponse = tvShow.genres else { return }
            var genresList = ""
            for genre in genresResponse {
                genresList += (genre.name ?? "") + "\n"
            }
            genres.text = genresList
        }
    }
}
