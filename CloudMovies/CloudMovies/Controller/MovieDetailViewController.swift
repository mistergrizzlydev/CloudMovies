//
//  MovieDetailController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let posterImage = UIImageView()
    private let contrainer = UIView()
    private let titleLabel = UILabel()
    private let date = UILabel()
    private let genres = UILabel()
    private let overview = UILabel()
    private let subtitleLabel = UILabel()
    private var genresName = [String]()
    private let watchListButton = UIButton(type: .system)
    private lazy var viewModel = MovieDetailsViewModel(delegate: self)
    var movieId: Int = 0
    var tvShowId: Int = 0
    
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    private func setupUI() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // Scroll View
        scrollView.delegate = self
        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        contrainer.clipsToBounds = true
        contrainer.contentMode = .scaleAspectFill
        contrainer.backgroundColor = .white
        contrainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
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
        // WatchListButton
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .small
        config.background.backgroundColor = .systemRed
        watchListButton.translatesAutoresizingMaskIntoConstraints = false
        watchListButton.setTitle("Add to Watchlist", for: [])
        watchListButton.setTitleColor(.white, for: .normal)
        watchListButton.configuration = config
        //        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        overview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contrainer)
        view.addSubview(titleLabel)
        contrainer.addSubview(posterImage)
        view.addSubview(date)
        view.addSubview(genres)
        view.addSubview(overview)
        view.addSubview(watchListButton)
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
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
            genres.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            //            genres.heightAnchor.constraint(equalTo: posterImage.heightAnchor, multiplier: 0.3)
            //            genres.bottomAnchor.constraint(equalTo: overview.topAnchor, constant: 8)
        ])
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: genres.bottomAnchor),
            overview.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            overview.bottomAnchor.constraint(equalTo: posterImage.bottomAnchor),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
        NSLayoutConstraint.activate([
            watchListButton.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 24),
            watchListButton.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor),
            watchListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            watchListButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        ])
        NSLayoutConstraint.activate([
            
        ])
        
    }
    private func selectData() {
        if movieId != 0 {
            viewModel.getMovieDetails(movieId: movieId)
        } else {
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

extension MovieDetailViewController: ViewModelProtocol {
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


extension MovieDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
