//
//  GenresViewController.swift
//  PopCornCine
//
//  Created by Артем Билый on 28.09.2022.
//

import UIKit

class GenresViewController: UIViewController {
    //MARK: - ViewModel

    
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
    }
    
    override func viewDidLayoutSubviews() {
        colletionView.frame = view.bounds
    }
//MARK: - Methods
    
    private func setupUI() {
        // colletionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: PopularMovieCell.cellIdentifier)
        view.addSubview(colletionView)
        let signOut = UIBarButtonItem(customView: signOutButton)
        navigationItem.rightBarButtonItems = [signOut]
        title = "Popcorn Cine"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func delegate() {
                colletionView.delegate = self
                colletionView.dataSource = self
    }
}


//MARK: CompositionalCollectionViewLayout method
func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.2))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .estimated(50.0))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                             alignment: .topLeading)
    let section = NSCollectionLayoutSection(group: group)
    
    section.boundarySupplementaryItems = [header]
    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
}


extension GenresViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       UICollectionViewCell()
    }
}

extension GenresViewController: UICollectionViewDelegate {
    
}
