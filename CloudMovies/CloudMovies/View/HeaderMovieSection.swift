//
//  HeaderCell.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//

import Foundation

import UIKit

class HeaderMovieSection: UICollectionViewCell {
    
    static let headerIdentifier = "headerIdentifier"
    
    fileprivate let contrainer = UIView()
    fileprivate let leftElemnt = UIView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    override func layoutSubviews() {
        setupConstraint()
    }
    
    private func configureView() {
        contentView.backgroundColor = .systemBackground
        
        contrainer.backgroundColor = .systemBackground
        contrainer.translatesAutoresizingMaskIntoConstraints = false
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.minimumContentSizeCategory = .accessibilityMedium
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        leftElemnt.backgroundColor = .systemIndigo
        leftElemnt.translatesAutoresizingMaskIntoConstraints = false
        leftElemnt.layer.cornerRadius = 4
        
        contentView.addSubview(contrainer)
        contrainer.addSubview(label)
        contrainer.addSubview(leftElemnt)
    }
    
    private func setupConstraint() {
        contrainer.widthAnchor.constraint(equalToConstant: contentView.bounds.width).isActive = true
        contrainer.heightAnchor.constraint(equalToConstant: contentView.bounds.height).isActive = true
        contrainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contrainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        leftElemnt.topAnchor.constraint(equalTo: contrainer.topAnchor, constant: 8).isActive = true
        leftElemnt.bottomAnchor.constraint(equalTo: contrainer.bottomAnchor, constant: -10).isActive = true
        leftElemnt.leftAnchor.constraint(equalTo: contrainer.leftAnchor, constant: 8).isActive = true
        leftElemnt.rightAnchor.constraint(equalTo: label.leftAnchor, constant: 4).isActive = true
        label.bottomAnchor.constraint(equalTo: contrainer.bottomAnchor, constant: -8).isActive = true
        label.leftAnchor.constraint(equalTo: leftElemnt.leftAnchor, constant: 4).isActive = true
    }
}
