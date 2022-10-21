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
    private let container = UIView()
    private let posterImage = UIImageView()
    private let title = UILabel()
    private let saveButton = UIButton(type: .custom)
    
    
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
        container.translatesAutoresizingMaskIntoConstraints = false
        container.contentMode = .scaleAspectFill
//        container.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMaxYCorner]
        container.clipsToBounds = true
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.contentMode = .scaleAspectFill
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.textAlignment = .left
        title.adjustsFontForContentSizeCategory = true
        title.minimumContentSizeCategory = .small
        title.font = UIFont.preferredFont(forTextStyle: .caption1)

        saveButton.setImage(UIImage(named: "addwatchlist"), for: .normal)
        saveButton.setImage(UIImage(named: "addwatchlist"), for: .selected)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        contentView.layer.cornerRadius = 12
        contentView.dropShadow()
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(container)
        container.addSubview(posterImage)
        container.addSubview(title)
//        container.addSubview(saveButton)
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
        
        title.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 4).isActive = true
        title.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -8).isActive = true
        title.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8).isActive = true
        
//        saveButton.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
//        saveButton.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
//        saveButton.heightAnchor.constraint(equalToConstant: container.frame.height / 7).isActive = true
//        saveButton.widthAnchor.constraint(equalToConstant: container.frame.width / 5).isActive = true
    }
    //MARK: - Test Kingfisher
    func bindWithView(movie: Movie) {
        title.text = movie.title
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        posterImage.kf.setImage(with: url)
    }
}
