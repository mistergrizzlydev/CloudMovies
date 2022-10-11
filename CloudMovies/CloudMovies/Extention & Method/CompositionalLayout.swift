//
//  CompositionalLayout.swift
//  CloudMovies
//
//  Created by Артем Билый on 11.10.2022.
//
import UIKit

//MARK: CompositionalCollectionViewLayout method
func layout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 4, trailing: 4)
    let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(250))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                             alignment: .topLeading)
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [header]
    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.scrollDirection = .vertical
    let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
    return layout
}
