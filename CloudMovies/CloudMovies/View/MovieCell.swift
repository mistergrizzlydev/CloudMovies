//
//  MovieCell.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//

import UIKit
import Kingfisher

final class MovieCell: UICollectionViewCell {
    
    static let cellIdentifier = "cellIdentifier"
    
    //MARK: MovieCell UI Elements
    fileprivate let container = UIView()
    fileprivate let posterImage = UIImageView()
    fileprivate let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    override func layoutSubviews() {
        setupContraints()
    }
    
    //MARK: - ConfigureCell
    private func configureView() {
        container.clipsToBounds = true
        container.layer.cornerRadius = 12
        container.translatesAutoresizingMaskIntoConstraints = false
        container.contentMode = .scaleAspectFill
        container.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.contentMode = .scaleAspectFill
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.textAlignment = .left
        title.adjustsFontForContentSizeCategory = true
        title.minimumContentSizeCategory = .medium
        title.font = UIFont.preferredFont(forTextStyle: .caption2)
        
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemBackground
//        contentView.dropShadow()
        contentView.addSubview(container)
        container.addSubview(posterImage)
        container.addSubview(title)
    }
    //MARK: MovieCell Contraints
    private func setupContraints() {
        container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        posterImage.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0).isActive = true
        posterImage.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0).isActive = true
        posterImage.topAnchor.constraint(equalTo: container.topAnchor, constant: 0).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -50).isActive = true
        
        title.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 8).isActive = true
        title.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -8).isActive = true
//        title.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 8).isActive = true
        title.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8).isActive = true
    }
    
    //MARK: - Test Kingfisher
    func bindWithView(movie: Movie) {
        title.text = movie.title
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        posterImage.kf.setImage(with: url)
    }
}
