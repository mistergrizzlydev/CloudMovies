//
//  GenreListController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

final class DiscoverViewController: UIViewController {
    // view model
    lazy var viewModel = DiscoverViewModel()
    // MARK: - UI
    private let blur: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private lazy var colletionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        return collectionView
    }()
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Discover", "Movies", "TVShows"])
        let titleTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentedControl.setTitleTextAttributes(titleTextAttribute, for: .selected)
        segmentedControl.setTitleTextAttributes(titleTextAttribute, for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = #colorLiteral(red: 0.9531050324, green: 0.9531050324, blue: 0.9531050324, alpha: 1)
        return segmentedControl
    }()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        setupUI()
        loadMovies()
    }
    override func viewDidLayoutSubviews() {
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    // MARK: - Delegate
    private func delegate() {
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.register(MediaCell.self, forCellWithReuseIdentifier: MediaCell.identifier)
        colletionView.register(DiscoverHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DiscoverHeader.identifier)
    }
    // MARK: - Configure UI
    private func setupUI() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Cloud Movies"
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        colletionView.translatesAutoresizingMaskIntoConstraints = false
        colletionView.backgroundColor = #colorLiteral(red: 0.9531050324, green: 0.9531050324, blue: 0.9531050324, alpha: 1)
        view.addSubview(segmentedControl)
        view.addSubview(colletionView)
        view.addSubview(blur)
        colletionView.showsVerticalScrollIndicator = true
        segmentedControl.addTarget(self, action: #selector(segmentedControlPressed), for: .allEvents)
    }
    private func loadMovies() {
        viewModel.getDiscoverScreen()
        viewModel.getSortedMovies()
        viewModel.getSortedTVShows()
    }
    // MARK: - Configure layout
    private func setupLayout() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            colletionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
            colletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colletionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colletionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            blur.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blur.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blur.heightAnchor.constraint(equalTo: tabBarController!.tabBar.heightAnchor, multiplier: 1)
        ])
    }
    @objc func segmentedControlPressed() {
        colletionView.reloadData()
    }
}

// MARK: - DataSource
extension DiscoverViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return MovieSection.allCases.count
        case 1:
            return viewModel.sortedMovies.keys.count
        case 2:
            return viewModel.sortedTVShow.keys.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = MovieSectionNumber(rawValue: section)
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            switch section {
            case .onGoing:
                return viewModel.onGoind.count
            case .upcoming:
                return viewModel.upcoming.count
            case .popular:
                return viewModel.popular.count
            case .topRated:
                return viewModel.topRated.count
            case .popularTVShows:
                return viewModel.popularTVShows.count
            case .topRatedTVShows:
                return viewModel.topRatedTVShows.count
            case .thisWeek:
                return viewModel.thisWeekTVShows.count
            case .newEpisodes:
                return viewModel.newEpisodes.count
            case .none:
                return 0
            }
        case 1:
            return viewModel.sortedMovies.values.count
        case 2:
            return viewModel.sortedTVShow.values.count
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCell.identifier, for: indexPath) as? MediaCell else {
            return UICollectionViewCell()
        }
        let section = MovieSectionNumber(rawValue: indexPath.section)
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            switch section {
            case .onGoing:
                let movie = viewModel.onGoind[indexPath.item]
                cell.bindWithViewMovie(movie: movie)
                return cell
            case .upcoming:
                let movie = viewModel.upcoming[indexPath.item]
                cell.bindWithViewMovie(movie: movie)
                return cell
            case .popular:
                let movie = viewModel.popular[indexPath.item]
                cell.bindWithViewMovie(movie: movie)
                return cell
            case .topRated:
                let movie = viewModel.topRated[indexPath.item]
                cell.bindWithViewMovie(movie: movie)
                return cell
            case .popularTVShows:
                let tvShow = viewModel.popularTVShows[indexPath.item]
                cell.bindWithViewTVShow(tvShow: tvShow)
                return cell
            case .topRatedTVShows:
                let tvShow = viewModel.topRatedTVShows[indexPath.item]
                cell.bindWithViewTVShow(tvShow: tvShow)
                return cell
            case .thisWeek:
                let tvShow = viewModel.thisWeekTVShows[indexPath.item]
                cell.bindWithViewTVShow(tvShow: tvShow)
                return cell
            case .newEpisodes:
                let tvShow = viewModel.newEpisodes[indexPath.item]
                cell.bindWithViewTVShow(tvShow: tvShow)
                return cell
            case .none:
                return cell
            }
        case 1:
            let genre = viewModel.sortedMovies.keys.sorted(by: <)[indexPath.section]
            let movie = viewModel.sortedMovies[genre]![indexPath.item]
            cell.bindWithViewMovie(movie: movie)
            return cell
        case 2:
            let genre = viewModel.sortedTVShow.keys.sorted(by: <)[indexPath.section]
            let tvShow = viewModel.sortedTVShow[genre]![indexPath.item]
            cell.bindWithViewTVShow(tvShow: tvShow)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DiscoverHeader.identifier, for: indexPath) as? DiscoverHeader else {
                return UICollectionReusableView()
            }
            let section = MovieSectionNumber(rawValue: indexPath.section)
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                switch section {
                case .onGoing:
                    sectionHeader.label.text = MovieSection.onGoing.rawValue
                    return sectionHeader
                case .upcoming:
                    sectionHeader.label.text = MovieSection.upcoming.rawValue
                    return sectionHeader
                case .popular:
                    sectionHeader.label.text = MovieSection.popular.rawValue
                    return sectionHeader
                case .topRated:
                    sectionHeader.label.text = MovieSection.topRated.rawValue
                    return sectionHeader
                case .popularTVShows:
                    sectionHeader.label.text = MovieSection.popularTVShows.rawValue
                    return sectionHeader
                case .topRatedTVShows:
                    sectionHeader.label.text = MovieSection.topRatedTVShows.rawValue
                    return sectionHeader
                case .thisWeek:
                    sectionHeader.label.text = MovieSection.thisWeek.rawValue
                    return sectionHeader
                case .newEpisodes:
                    sectionHeader.label.text = MovieSection.newEpisodes.rawValue
                    return sectionHeader
                case .none:
                    return sectionHeader
                }
            case 1:
                sectionHeader.label.text = viewModel.sortedMovies.keys.sorted(by: <)[indexPath.section]
                return sectionHeader
            case 2:
                sectionHeader.label.text = viewModel.sortedTVShow.keys.sorted(by: <)[indexPath.section]
                return sectionHeader
            default:
                return UICollectionReusableView()
            }
        } else {
            return UICollectionReusableView()
        }
    }
}
// MARK: - Push Detatil VC
extension DiscoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let secondViewController = MovieDetailViewController(movieId: movieListViewModel)
        //        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
extension DiscoverViewController: UIActionSheetDelegate {
    
}
extension DiscoverViewController: ViewModelProtocol {
    func updateView() {
        self.colletionView.reloadData()
    }
    
    func showAlert() {
//                showingAlert()
    }
}
