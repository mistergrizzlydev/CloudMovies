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
        setupUI()
       
        viewModel.getMovieDetails(movieId: movieId)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.tintColor = .white

        // Remove 'Back' text and Title from Navigation Bar
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        self.title = viewModel.currentMovie?.title
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = .clear
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//        self.navigationController?.navigationBar.barStyle = .black
//        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    private func setupUI() {
        //Scroll View
        scrollView.delegate = self
        view.backgroundColor = .white
        self.view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        // Header Container
        headerContainerView.backgroundColor = .white
        self.scrollView.addSubview(headerContainerView)
        
        //Label
        titleLabel.backgroundColor = .white
        titleLabel.numberOfLines = 0
        self.scrollView.addSubview(titleLabel)
        
        //Image View
        posterImage.clipsToBounds = true
        posterImage.backgroundColor = .white
        posterImage.contentMode = .scaleAspectFill
        self.headerContainerView.addSubview(posterImage)
        
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.text = "Hello"
        
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
            self.titleLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: view.frame.height / 2.5)
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
        let movie = viewModel.currentMovie
        let url = URL(string: "https://image.tmdb.org/t/p/original\(movie?.posterPath ?? "")")
        posterImage.kf.setImage(with: url)
        titleLabel.text = movie?.originalTitle
    }
}
    
    
    
    
    
    
    //class MovieDetailViewController: UIViewController, UIScrollViewDelegate {
    //    var scrollView: UIScrollView!
    //
    //    var label: UILabel!
    //
    //    var headerContainerView: UIView!
    //
    //    var imageView: UIImageView!
    //    override func viewWillLayoutSubviews() {
    //        super.viewWillLayoutSubviews()
    //        setViewConstraints()
    //    }
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        createViews()
    //
    //        // ScrollView
    //        scrollView.backgroundColor = .systemGray
    //
    //        // Label Customization
    //        label.backgroundColor = .clear
    //        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    //        label.textColor = .white
    //        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    //
    //        // Set Image on the Header
    //        imageView.image = UIImage(named: "star")
    //        self.navigationController?.navigationBar.prefersLargeTitles = true
    ////        self.navigationItem.titleView = setTitle(title: "Title", subtitle: "SUBTITLE")
    //    }
    //
    //    func createViews() {
    //        // ScrollView
    //        scrollView = UIScrollView()
    //        scrollView.delegate = self
    //        self.view.addSubview(scrollView)
    //
    //        // Label
    //        label = UILabel()
    //        label.backgroundColor = .white
    //        label.numberOfLines = 0
    //        self.scrollView.addSubview(label)
    //
    //        // Header Container
    //        headerContainerView = UIView()
    //        headerContainerView.backgroundColor = .gray
    //        self.scrollView.addSubview(headerContainerView)
    //
    //        // ImageView for background
    //        imageView = UIImageView()
    //        imageView.clipsToBounds = true
    //        imageView.backgroundColor = .green
    //        imageView.contentMode = .scaleAspectFill
    //        self.headerContainerView.addSubview(imageView)
    //    }
    //
    //    func setViewConstraints() {
    //        // ScrollView Constraints
    //        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
    //            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
    //            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
    //            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    //        ])
    //
    //        // Label Constraints
    //        self.label.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
    //            self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
    //            self.label.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -10),
    //            self.label.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 280)
    //        ])
    //
    //        // Header Container Constraints
    //        let headerContainerViewBottom : NSLayoutConstraint!
    //
    //        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            self.headerContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
    //            self.headerContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
    //            self.headerContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    //        ])
    //        headerContainerViewBottom = self.headerContainerView.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: -10)
    //        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
    //        headerContainerViewBottom.isActive = true
    //
    //        // ImageView Constraints
    //        let imageViewTopConstraint: NSLayoutConstraint!
    //        imageView.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            self.imageView.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor),
    //            self.imageView.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor),
    //            self.imageView.bottomAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor)
    //        ])
    //
    //        imageViewTopConstraint = self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor)
    //        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
    //        imageViewTopConstraint.isActive = true
    //    }
    //
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        // Make sure the top constraint of the ScrollView is equal to Superview and not Safe Area
    //
    //        // Hide the navigation bar completely
    //        //self.navigationController?.setNavigationBarHidden(true, animated: false)
    //
    //
    //        // Make the Navigation Bar background transparent
    //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    //        self.navigationController?.navigationBar.shadowImage = UIImage()
    //        self.navigationController?.navigationBar.isTranslucent = true
    //        self.navigationController?.navigationBar.tintColor = .white
    //
    //        // Remove 'Back' text and Title from Navigation Bar
    //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //        self.title = "Movie"
    //    }
    //
    //
    //
    //final class MovieDetailViewController: UIViewController, UIScrollViewDelegate {
    //
    //    var scrollView: UIScrollView = {
    //        let scrollView = UIScrollView()
    //        return scrollView
    //    }()
    //
    //    var label: UILabel = {
    //        let label = UILabel()
    //        return label
    //    }()
    //
    //    var headerContainerView: UIView = {
    //        let headerContrainerView = UIView()
    //        return headerContrainerView
    //    }()
    //
    //    var imageView: UIImageView = {
    //        let imageView = UIImageView()
    //        return imageView
    //    }()
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        setupUI()
    //
    //    }
    //
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    //        self.navigationController?.navigationBar.shadowImage = UIImage()
    //        self.navigationController?.navigationBar.isTranslucent = true
    //        self.navigationController?.navigationBar.tintColor = .white
    //
    //        // Remove 'Back' text and Title from Navigation Bar
    //        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    //        self.title = ""
    //    }
    //
    //    override func viewWillLayoutSubviews() {
    //
    //    }
    //
    //    //    private var movieId: Int
    //    //
    //    //    init(movieId: Int) {
    //    //        self.movieId = movieId
    //    //        super.init(nibName: nil, bundle: nil)
    //    //    }
    //
    //    //    required init?(coder: NSCoder) {
    //    //        fatalError("init(coder:) has not been implemented")
    //    //    }
    //    //
    //    private func setupUI() {
    //        //Scroll view
    //        scrollView.delegate = self
    //        scrollView.backgroundColor = .systemGray
    //        self.view.addSubview(scrollView)
    //        //Label
    //        label.backgroundColor = .white
    //        label.numberOfLines = 0
    //        label.backgroundColor = .clear
    //        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    //        label.textColor = .white
    //        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    //        self.scrollView.addSubview(label)
    //        // Header Container
    //        headerContainerView = UIView()
    //        headerContainerView.backgroundColor = .gray
    //        self.scrollView.addSubview(headerContainerView)
    //        // ImageView for background
    //        imageView = UIImageView()
    //        imageView.clipsToBounds = true
    //        imageView.backgroundColor = .green
    //        imageView.contentMode = .scaleAspectFill
    //        imageView.image = UIImage(named: "star")
    //        self.headerContainerView.addSubview(imageView)
    //    }
    //
    //    private func setupLayout() {
    //        func setViewConstraints() {
    //            // ScrollView Constraints
    //            self.scrollView.translatesAutoresizingMaskIntoConstraints = false
    //            NSLayoutConstraint.activate([
    //                self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
    //                self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
    //                self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
    //                self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    //            ])
    //
    //            // Label Constraints
    //            self.label.translatesAutoresizingMaskIntoConstraints = false
    //            NSLayoutConstraint.activate([
    //                self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
    //                self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
    //                self.label.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -10),
    //                self.label.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 280)
    //            ])
    //
    //            // Header Container Constraints
    //            let headerContainerViewBottom : NSLayoutConstraint!
    //
    //            self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
    //            NSLayoutConstraint.activate([
    //                self.headerContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
    //                self.headerContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
    //                self.headerContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    //            ])
    //            headerContainerViewBottom = self.headerContainerView.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: -10)
    //            headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
    //            headerContainerViewBottom.isActive = true
    //
    //            // ImageView Constraints
    //            let imageViewTopConstraint: NSLayoutConstraint!
    //            imageView.translatesAutoresizingMaskIntoConstraints = false
    //            NSLayoutConstraint.activate([
    //                self.imageView.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor),
    //                self.imageView.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor),
    //                self.imageView.bottomAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor)
    //            ])
    //
    //            imageViewTopConstraint = self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor)
    //            imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
    //            imageViewTopConstraint.isActive = true
    //        }
    //    }
    //}
