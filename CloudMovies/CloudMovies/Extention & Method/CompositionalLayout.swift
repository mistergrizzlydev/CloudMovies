//
//  GenreLayout.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

struct ElementKind {
    static let badge = "badge-element-kind"
    static let background = "background-element-kind"
    static let sectionHeader = "section-header-element-kind"
    static let sectionFooter = "section-footer-element-kind"
    static let layoutHeader = "layout-header-element-kind"
    static let layoutFooter = "layout-footer-element-kind"
}

//MARK: CompositionalCollectionViewLayout
func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 4)
    let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(180), heightDimension: .absolute(310))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 0)
    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.05))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                             elementKind: UICollectionView.elementKindSectionHeader,
                                                             alignment: .topLeading)
//    header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0)
    let section = NSCollectionLayoutSection(group: group)
    section.boundarySupplementaryItems = [header]
    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: ElementKind.background)
    
    section.decorationItems = [sectionBackground]
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.scrollDirection = .vertical
    config.interSectionSpacing = 16
    let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
    layout.register(
        BackgroundView.self,
        forDecorationViewOfKind: ElementKind.background)
    return layout
}
