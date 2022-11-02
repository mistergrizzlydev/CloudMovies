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
    private var movieId: Int
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovieDetails(movieId: movieId)
        setupUI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white

        // Remove 'Back' text and Title from Navigation Bar
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = ""
    }
    
    private func setupUI() {
        // Scroll View
        scrollView.delegate = self
        view.backgroundColor = .white
        self.view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        // Header Container
        headerContainerView.backgroundColor = .white
        self.scrollView.addSubview(headerContainerView)
        // Label
        titleLabel.backgroundColor = .white
        titleLabel.numberOfLines = 0
        self.scrollView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.text = "Hello"
        // Image View
        posterImage.clipsToBounds = true
        posterImage.backgroundColor = .white
        posterImage.contentMode = .scaleAspectFill
        self.headerContainerView.addSubview(posterImage)
        // Set Image on the Header
    }
    private func setupLayout() {
        // ScrollView Constraints
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        // Label Constraints
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -10),
            self.titleLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: view.frame.height / 4 * 3)
        ])
        // Header Container Constraints
        let headerContainerViewBottom : NSLayoutConstraint!
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.headerContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        headerContainerViewBottom = self.headerContainerView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: -10)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerViewBottom.isActive = true
        // ImageView Constraints
        let imageViewTopConstraint: NSLayoutConstraint!
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.posterImage.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor),
            self.posterImage.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor),
            self.posterImage.bottomAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor)
        ])
        imageViewTopConstraint = self.posterImage.topAnchor.constraint(equalTo: self.view.topAnchor)
        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        imageViewTopConstraint.isActive = true
    }
}

extension MovieDetailViewController: ViewModelProtocol {
    func updateView() {
        guard let movie = viewModel.currentMovie else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath ?? "")")
        posterImage.kf.setImage(with: url)
        titleLabel.text = (movie.title ?? "")
    }
}
