//
//  GenresViewController.swift
//  PopCornCine
//
//  Created by Артем Билый on 28.09.2022.
//

import UIKit

class GenresViewController: UIViewController {
    //MARK: - ViewModel
    
    private var viewModelMovie: MovieListViewModel
    private var viewModelGenre: GenreListViewModel
    
    init(viewModelMovie: MovieListViewModel, viewModelGenre: GenreListViewModel) {
        self.viewModelMovie = viewModelMovie
        self.viewModelGenre = viewModelGenre
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Elements
    private lazy var colletionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        return collectionView
    }()
    
    private lazy var signOutButton: UIButton = {
        let signOutButton = UIButton.init(type: .system)
        signOutButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        signOutButton.setTitle("Sign out", for: .normal)
        signOutButton.setImage(UIImage(systemName: "pip.exit"), for: .normal)
        return signOutButton
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        setupUI()
        fetchMovies()
        fetchGenrees()
        bindViewModelEvent()
    }
    
    override func viewDidLayoutSubviews() {
        colletionView.frame = view.bounds
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        let signOut = UIBarButtonItem(customView: signOutButton)
        navigationItem.rightBarButtonItems = [signOut]
        title = "Popcorn Cine"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(colletionView)
        colletionView.showsVerticalScrollIndicator = true
        colletionView.showsHorizontalScrollIndicator = true
        colletionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.cellIdentifier)
        colletionView.register(HeaderMovieSection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderMovieSection.headerIdentifier)
    }
    
    private func delegate() {
        colletionView.delegate = self
        colletionView.dataSource = self
    }
    
    private func fetchGenrees() {
        viewModelGenre.fetchGenres()
    }
    
    private func fetchMovies() {
        viewModelMovie.fetchMovie()
    }
    
    private func bindViewModelEvent() {
        viewModelMovie.onFetchMovieSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.colletionView.reloadData()
            }
        }
        
        viewModelMovie.onFetchMovieFailure = { error in
            print(error)
        }
        
        viewModelGenre.onFetchGenresSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.colletionView.reloadData()
            }
        }
        
        viewModelGenre.onFetchGenresFailure = { error in
            print(error)
        }
        
    }
}

extension GenresViewController: UICollectionViewDataSource {
    
    
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
        //
        let movie = viewModelMovie.movies[indexPath.row]
        //        let genre = viewModelGenre.genres[indexPath.row].id
        cell.bindWithView(viewModel: MovieDefaultViewModel(movie: movie))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderMovieSection.headerIdentifier, for: indexPath) as? HeaderMovieSection else {
                return UICollectionReusableView()
            }

            let genre = viewModelGenre.genres[indexPath.section].name
            sectionHeader.label.text = "  \(genre!)"
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
}
extension GenresViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secondViewController = DetailsScreenViewController()
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
