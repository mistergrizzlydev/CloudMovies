//
//  HeaderCell.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//

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
        NSLayoutConstraint.activate([
            contrainer.widthAnchor.constraint(equalToConstant: contentView.bounds.width),
            contrainer.heightAnchor.constraint(equalToConstant: contentView.bounds.height),
            contrainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contrainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contrainer.leadingAnchor, constant: 24),
            label.topAnchor.constraint(equalTo: contrainer.topAnchor),
            label.bottomAnchor.constraint(equalTo: contrainer.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            leftElemnt.topAnchor.constraint(equalTo: contrainer.topAnchor, constant: 8),
            leftElemnt.leadingAnchor.constraint(equalTo: contrainer.leadingAnchor, constant: 8),
            leftElemnt.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8),
            leftElemnt.bottomAnchor.constraint(equalTo: contrainer.bottomAnchor, constant: -8)
        ])
    }
}
