//
//  HeaderMovieCell.swift
//  PopCornCine
//
//  Created by Артем Билый on 30.09.2022.
//

import UIKit

class HeaderMovieSection: UICollectionViewCell {
    
    static let headerIdentifier = "headerIdentifier"
    
    fileprivate let contrainer = UIView()
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
        
        contrainer.backgroundColor = .systemGray5
        contrainer.translatesAutoresizingMaskIntoConstraints = false
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.minimumContentSizeCategory = .accessibilityLarge
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        
        contentView.addSubview(contrainer)
        contrainer.addSubview(label)
    }
    
    private func setupConstraint() {
        contrainer.widthAnchor.constraint(equalToConstant: contentView.bounds.width).isActive = true
        contrainer.heightAnchor.constraint(equalToConstant: contentView.bounds.height).isActive = true
        contrainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contrainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contrainer.bottomAnchor, constant: -8).isActive = true
        label.leftAnchor.constraint(equalTo: contrainer.leftAnchor, constant: 16).isActive = true
    }
}
