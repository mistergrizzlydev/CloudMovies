//
//  GenreListController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

final class GenreListViewController: UIViewController {
    
    private var viewModelMovie: MovieListViewModel
    private var viewModelGenre: GenreListViewModel
    
    init(viewModelMovie: MovieListViewModel, viewModelGenre: GenreListViewModel) {
        self.viewModelGenre = viewModelGenre
        self.viewModelMovie = viewModelMovie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var colletionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        return collectionView
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
//        presentAuthorizationVC()
        setupUI()
        fetchGenres()
        fetchMovies()
        bindViewModelGenreEvent()
        bindViewModelMovieEvent()
    }
    
    override func viewDidLayoutSubviews() {
        colletionView.frame = view.bounds
    }
    
    private func presentAuthorizationVC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let authorizationVC = AuthorizationViewController()
            authorizationVC.modalPresentationStyle = .fullScreen
            self.present(authorizationVC, animated: true)
        }
    }
    
    private func delegate() {
        colletionView.delegate = self
        colletionView.dataSource = self
    }
    
    private func setupUI() {
        title = "CloudMovies"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(colletionView)
        colletionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.cellIdentifier)
        colletionView.register(HeaderMovieSection.self, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderMovieSection.headerIdentifier)
        colletionView.showsVerticalScrollIndicator = true
    }
    
    private func fetchGenres() {
        viewModelGenre.fetchGenres()
    }
    
    private func bindViewModelGenreEvent() {
        viewModelGenre.onFetchGenresSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.colletionView.reloadData()
            }
        }
        viewModelGenre.onFetchGenresFailure = { error in
            print(error)
        }
    }
    
    private func fetchMovies() {
        viewModelMovie.fetchMovie()
    }
    
    private func bindViewModelMovieEvent() {
        viewModelMovie.onFetchMovieSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.colletionView.reloadData()
            }
        }
        viewModelMovie.onFetchMovieFailure = { error in
            print(error)
        }
    }
}


//MARK: - Methods
extension GenreListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModelGenre.genres.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModelMovie.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.cellIdentifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        let movie = viewModelMovie.movies[indexPath.row]
        cell.bindWithView(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderMovieSection.headerIdentifier, for: indexPath) as? HeaderMovieSection else {
                return UICollectionReusableView()
            }
            let genreName = viewModelGenre.genres[indexPath.section].name
            sectionHeader.label.text = " \(genreName ?? "Nil")"
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
}

extension GenreListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = MovieDetailViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
