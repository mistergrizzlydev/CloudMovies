//
//  CompositionalLayout.swift
//  PopCornCine
//
//  Created by Артем Билый on 30.09.2022.
//

import UIKit

//MARK: CompositionalCollectionViewLayout method
func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(250))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
    
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .absolute(50.0))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                             alignment: .topLeading)
    let section = NSCollectionLayoutSection(group: group)
    
    section.boundarySupplementaryItems = [header]
    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
}
