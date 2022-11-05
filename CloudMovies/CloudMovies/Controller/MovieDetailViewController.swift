//
//  MovieDetailController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController, UIScrollViewDelegate {
    private let scrollView = UIScrollView()
    private let headerContainerView = UIView()
    private let posterImage = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
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
//        view.addSubview(scrollView)
//        scrollView.backgroundColor = .white
        // Label
        titleLabel.backgroundColor = .white
//        titleLabel.numberOfLines = 0
//        self.scrollView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .black
        // Image View
        posterImage.clipsToBounds = true
        posterImage.backgroundColor = .white
        posterImage.contentMode = .scaleAspectFill
    }
    private func setupLayout() {
        
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
            titleLabel.text = (movie.title ?? "")
        } else {
            guard let tvShow = viewModel.currentTVShow else { return }
            self.navigationItem.title = tvShow.name
            let url = URL(string: "https://image.tmdb.org/t/p/w780\(tvShow.posterPath ?? "")")
            posterImage.kf.setImage(with: url)
            titleLabel.text = tvShow.name
        }
    }
}
