//
//  MovieDetailController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    // MARK: - Init UI
    // Alert
    private lazy var bottomAlert: AlertCreator = {
        return AlertCreator()
    }()
    private let posterImage = UIImageView()
    private let contrainer = UIView()
    private let titleLabel = UILabel()
    private let date = UILabel()
    private let genres = UILabel()
    private let overview = UILabel()
    private let subtitleLabel = UILabel()
    private var genresName = [String]()
    private let watchListButton = UIButton(type: .custom)
    private let setRateButton = UIButton(type: .system)
    private let overviewButton = UIButton(type: .system)
    private let loaderView = UIActivityIndicatorView()
    // View model
    private lazy var viewModel = MovieDetailsViewModel(delegate: self)
    private let dots = UIPageControl()
    private lazy var setRateController = SetRateController()
    private lazy var videoCollectionView: UICollectionView = {
        let videoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createVideoLayout())
        videoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        videoCollectionView.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.identifier)
        return videoCollectionView
    }()
    private let voteAverage = UILabel()
    private let star = UIImageView()
    // Helpers
    var movieId: Int = 0
    var tvShowId: Int = 0
    var mediaType: String = ""
    var isFavourite: Bool = false
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        selectData()
        setTitle()
        setupUI()
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
        mediaType = ""
        watchListButton.isHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSavedList()
        dealWithButton()
    }
    // MARK: - Loading Data
    private func selectData() {
        if movieId != 0 {
            viewModel.getVideosMovies(movieID: movieId)
            viewModel.getMovieDetails(movieID: movieId)
        } else {
            viewModel.getVideosTV(tvShowID: tvShowId)
            viewModel.getTVShowDetails(tvShowId: tvShowId)
        }
    }
    // MARK: - Download new list
    private func updateSavedList() {
        CheckInWatchList.shared.getMoviesID {
            print("success")
        }
        CheckInWatchList.shared.getTVShowsID {
            print("success")
        }
    }
    // MARK: - Setup UI
    private func setTitle() {
        if movieId != 0 {
            navigationItem.title = viewModel.currentMovie?.title
        } else {
            navigationItem.title = viewModel.currentTVShow?.name
        }
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
        overview.numberOfLines = 0
        overview.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        overview.translatesAutoresizingMaskIntoConstraints = false
        // WatchListButton
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .small
        config.titleAlignment = .center
        config.background.backgroundColor = .systemRed
        watchListButton.translatesAutoresizingMaskIntoConstraints = false
        watchListButton.configuration = config
        watchListButton.setTitle("Add to Watchlist", for: .normal)
        watchListButton.setTitle("Remove from watchlist", for: .selected)
        watchListButton.addTarget(self, action: #selector(mediaAction), for: .primaryActionTriggered)
        watchListButton.dropShadow()
        //
        setRateButton.translatesAutoresizingMaskIntoConstraints = false
        setRateButton.setImage(UIImage(systemName: "star"), for: .normal)
        setRateButton.setTitle("Rate", for: [])
        setRateButton.setTitleColor(.white, for: .normal)
        setRateButton.configuration = config
        setRateButton.addAction(UIAction {_ in
            self.setRateController.modalPresentationStyle = .fullScreen
            self.setRateController.backgroundView.image = self.posterImage.image
            self.setRateController.posterView.image = self.posterImage.image
            if self.movieId != 0 {
                self.setRateController.mediaType = .movie
                self.setRateController.mediaID = self.movieId
            } else {
                self.setRateController.mediaType = .tvShow
                self.setRateController.mediaID = self.tvShowId
            }
            self.present(self.setRateController, animated: true)
        }, for: .touchUpInside)
        setRateButton.dropShadow()
        //
        overviewButton.backgroundColor = .clear
        overviewButton.addAction(UIAction {_ in
            let overviewFullController = OverviewFullController(overview: self.overview.text ?? "")
            if let sheet = overviewFullController.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            self.present(overviewFullController, animated: true)
        }, for: .touchUpInside)
        overviewButton.translatesAutoresizingMaskIntoConstraints = false
        loaderView.color = .systemRed
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        //
        voteAverage.font = UIFont.systemFont(ofSize: 12)
        voteAverage.textColor = .black
        voteAverage.translatesAutoresizingMaskIntoConstraints = false
        //
        star.translatesAutoresizingMaskIntoConstraints = false
        star.contentMode = .scaleAspectFit
        star.image = UIImage(named: "star")
        //
        dots.pageIndicatorTintColor = .lightGray
        dots.currentPageIndicatorTintColor = .black
        dots.isUserInteractionEnabled = false
        dots.translatesAutoresizingMaskIntoConstraints = false
    }
    // MARK: Watchlist action
    @objc func mediaAction(_ sender: UIButton) {
        switch sender.isSelected {
        case true:
            var alert = UIAlertController()
            if movieId != 0 {
                alert = bottomAlert.createAlert(mediaType: MediaType.movie.rawValue, mediaID: String(movieId), sender: sender) {
                    
                }
            } else {
                alert = bottomAlert.createAlert(mediaType: MediaType.tvShow.rawValue, mediaID: String(tvShowId), sender: sender) {
                    
                }
            }
            self.present(alert, animated: true)
        case false:
            if movieId != 0 {
                viewModel.actionWithList(mediaType: MediaType.movie.rawValue, mediaID: String(movieId), boolean: true)
            } else {
                viewModel.actionWithList(mediaType: MediaType.tvShow.rawValue, mediaID: String(tvShowId), boolean: true)
            }
            sender.isSelected.toggle()
        }
    }
    private func dealWithButton() {
        if StorageSecure.keychain["guestID"] != nil {
            watchListButton.isHidden = true
        }
    }
    // MARK: Data Formatter
    private func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            return outputFormatter.string(from: date)
        }
        return nil
    }
    // MARK: - Constraints
    private func setupLayout() {
        view.addSubview(contrainer)
        view.addSubview(titleLabel)
        contrainer.addSubview(posterImage)
        view.addSubview(date)
        view.addSubview(genres)
        view.addSubview(star)
        view.addSubview(voteAverage)
        view.addSubview(overview)
        view.addSubview(overviewButton)
        view.addSubview(watchListButton)
        view.addSubview(setRateButton)
        view.addSubview(loaderView)
        view.addSubview(videoCollectionView)
        view.addSubview(dots)
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
            star.topAnchor.constraint(equalTo: genres.bottomAnchor, constant: -12),
            star.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            star.heightAnchor.constraint(equalToConstant: 16),
            star.widthAnchor.constraint(equalToConstant: 16)
        ])
        NSLayoutConstraint.activate([
            voteAverage.leadingAnchor.constraint(equalTo: star.trailingAnchor, constant: 4),
            voteAverage.centerYAnchor.constraint(equalTo: star.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: star.bottomAnchor, constant: 4),
            overview.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            overview.bottomAnchor.constraint(equalTo: posterImage.bottomAnchor),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            overviewButton.topAnchor.constraint(equalTo: star.bottomAnchor, constant: 4),
            overviewButton.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            overviewButton.bottomAnchor.constraint(equalTo: posterImage.bottomAnchor),
            overviewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            setRateButton.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 24),
            setRateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            setRateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            setRateButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        NSLayoutConstraint.activate([
            watchListButton.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 24),
            watchListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            watchListButton.trailingAnchor.constraint(equalTo: setRateButton.leadingAnchor, constant: -16),
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
}
// MARK: - CollectionView Delegate
extension MovieDetailViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        dots.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        dots.currentPage = indexPath.row
    }
}
// MARK: - CollectionView Data Source
extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.identifier,
                                                            for: indexPath) as? VideoCell else {
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
// MARK: - ViewModelProtocol
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
            posterImage.kf.indicatorType = .activity
            posterImage.kf.setImage(with: url)
            titleLabel.text = (movie.title ?? movie.originalTitle ?? "")
            let formattedText = formattedDateFromString(dateString: movie.releaseDate ?? "", withFormat: "MMM dd, yyyy")
            date.text = formattedText
            voteAverage.text = "\(round(movie.voteAverage ?? 0.0))"
            overview.text = movie.overview
            genresName.removeAll()
            guard let genresResponse = movie.genres else { return }
            var genresList = ""
            for genre in genresResponse {
                genresList += (genre.name ?? "") + "\n"
            }
            genres.text = genresList
            for int in CheckInWatchList.shared.movieList {
                if movie.id == int {
                    isFavourite = true
                }
            }
        } else {
            guard let tvShow = viewModel.currentTVShow else { return }
            self.navigationItem.title = tvShow.name
            let url = URL(string: "https://image.tmdb.org/t/p/w780\(tvShow.posterPath ?? "")")
            posterImage.kf.indicatorType = .activity
            posterImage.kf.setImage(with: url)
            titleLabel.text = tvShow.name
            let formattedText = formattedDateFromString(dateString: tvShow.firstAirDate ?? "",
                                                        withFormat: "MMM dd, yyyy")
            date.text = formattedText
            voteAverage.text = "\(round(tvShow.voteAverage ?? 0.0))"
            overview.text = tvShow.overview
            genresName.removeAll()
            guard let genresResponse = tvShow.genres else { return }
            var genresList = ""
            for genre in genresResponse {
                genresList += (genre.name ?? "") + "\n"
            }
            genres.text = genresList
            for int in CheckInWatchList.shared.tvShowList {
                if tvShow.id == int {
                    isFavourite = true
                }
            }
        }
        if isFavourite == true {
            watchListButton.isSelected = true
        }
    }
}
