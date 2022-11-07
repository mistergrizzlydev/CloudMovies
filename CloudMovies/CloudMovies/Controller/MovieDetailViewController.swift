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
    private let overview = UILabel()
    private let subtitleLabel = UILabel()
    private var genresName = [String]()
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
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        // Scroll View
        scrollView.delegate = self
        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        contrainer.translatesAutoresizingMaskIntoConstraints = false
        // Label
        titleLabel.backgroundColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(titleLabel)
        // Image View
        posterImage.clipsToBounds = true
        posterImage.backgroundColor = .white
        posterImage.contentMode = .scaleAspectFill
        posterImage.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(posterImage)
        // Overview
        overview.backgroundColor = .white
        overview.textColor = .black
        overview.textAlignment = .left
        overview.numberOfLines = 0
        overview.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        overview.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(overview)
        scrollView.addSubview(contrainer)
        contrainer.addSubview(titleLabel)
        contrainer.addSubview(posterImage)
        contrainer.addSubview(overview)
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            contrainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contrainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contrainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contrainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            posterImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            posterImage.heightAnchor.constraint(equalTo: posterImage.widthAnchor, multiplier: 1.5)
        ])
        NSLayoutConstraint.activate([
            overview.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            overview.bottomAnchor.constraint(equalTo: posterImage.bottomAnchor),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
            overview.text = movie.overview
            print(movie.overview)
            for genre in movie.genres! {
                genresName.append(genre.name ?? "")
            }
        } else {
            guard let tvShow = viewModel.currentTVShow else { return }
            self.navigationItem.title = tvShow.name
            let url = URL(string: "https://image.tmdb.org/t/p/w780\(tvShow.posterPath ?? "")")
            posterImage.kf.setImage(with: url)
            titleLabel.text = tvShow.name
            overview.text = tvShow.overview
            for genre in tvShow.genres! {
                genresName.append(genre.name ?? "")
            }
        }
    }
}

extension MovieDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
