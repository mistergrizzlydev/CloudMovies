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
    
//MARK: - MovieCell UI Elements
    private let container = UIView()
    private let posterImage = UIImageView()
    private let title = UILabel()
    private let saveButton = UIButton(type: .custom)
    private let voteAverage = UILabel()
    private let star = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContraints()
    }
    
//MARK: - ConfigureCell
    private func configureView() {
        container.clipsToBounds = true
        container.translatesAutoresizingMaskIntoConstraints = false
        container.contentMode = .scaleAspectFill
        container.backgroundColor = .white
        container.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        container.layer.cornerRadius = 8
        
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.contentMode = .scaleAspectFill
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 1
        title.textAlignment = .left
        title.textColor = .black
        title.minimumContentSizeCategory = .medium
        title.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        star.translatesAutoresizingMaskIntoConstraints = false
        star.contentMode = .scaleAspectFit
        star.image = UIImage(named: "star")
        
        saveButton.setImage(UIImage(named: "addwatchlist"), for: .normal)
        saveButton.setImage(UIImage(named: "checkmark"), for: .selected)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        voteAverage.font = UIFont.preferredFont(forTextStyle: .caption1)
        voteAverage.textColor = .black
        voteAverage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.dropShadow()
        
        contentView.addSubview(container)
        container.addSubview(title)
        container.addSubview(star)
        container.addSubview(voteAverage)
        container.addSubview(posterImage)
        container.addSubview(saveButton)
    }
//MARK: - MovieCell Contraints
    private func setupContraints() {
        NSLayoutConstraint.activate([
            container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            title.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            star.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            star.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -4),
            star.heightAnchor.constraint(equalToConstant: 14),
            star.widthAnchor.constraint(equalToConstant: 14)
        ])
        NSLayoutConstraint.activate([
            voteAverage.leadingAnchor.constraint(equalTo: star.trailingAnchor, constant: 4),
            voteAverage.centerYAnchor.constraint(equalTo: star.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: container.topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: star.topAnchor, constant: -16),
            posterImage.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0),
            posterImage.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0)
        ])

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: container.topAnchor),
            saveButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 32)
        ])
//        
//        star.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        posterImage.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
//MARK: - Test Kingfisher
    func bindWithViewMovie(movie: MoviesModel.Movie) {
        title.text = movie.title
        voteAverage.text = "\(movie.voteAverage ?? 0.0)"
        guard let poster = movie.posterPath else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)")
        posterImage.kf.setImage(with: url)
    }
    
    func bindWithViewTVShow(tvShow: TVShowsModel.TVShow) {
        title.text = tvShow.name
        voteAverage.text = "\(tvShow.voteAverage ?? 0.0)"
        guard let poster = tvShow.posterPath else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)")
        posterImage.kf.setImage(with: url)
    }
//MARK: - Select for save/delete item
    @objc func saveButtonPressed() {
        saveButton.isSelected.toggle()
    }

}
