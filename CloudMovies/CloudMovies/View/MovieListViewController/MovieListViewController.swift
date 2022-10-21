//
//  GenreListController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    private var movieListViewModel: MovieListViewModel
    
    init(movieListViewModel: MovieListViewModel) {
        self.movieListViewModel = movieListViewModel
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
//        presentAuthorizationVC()
        delegate()
        loadMovies()
        setupUI()
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
        colletionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.cellIdentifier)
        colletionView.register(HeaderMovieSection.self, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderMovieSection.headerIdentifier)
    }
    
    private func setupUI() {
        title = "CloudMovies"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(colletionView)
        colletionView.showsVerticalScrollIndicator = true
    }
    
    private func loadMovies() {
        movieListViewModel.sortedByGenres {
            DispatchQueue.main.async {
                self.colletionView.reloadData()
                print(Array(self.movieListViewModel.sortedMovies.keys).count)
            }
        }
    }
}
//MARK: - DataSource
extension MovieListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        movieListViewModel.sortedMovies.keys.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieListViewModel.sortedMovies.values.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.cellIdentifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        
        let genre = movieListViewModel.sortedMovies.keys.sorted(by: <)[indexPath.section]
        let movie = movieListViewModel.sortedMovies[genre]![indexPath.item]
        cell.bindWithView(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderMovieSection.headerIdentifier, for: indexPath) as? HeaderMovieSection else {
                return UICollectionReusableView()
            }
            sectionHeader.label.text = movieListViewModel.sortedMovies.keys.sorted(by: <)[indexPath.section]
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
}
//MARK: - Delegate
extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = MovieDetailViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
