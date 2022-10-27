//
//  SearchMovieCell.swift
//  CloudMovies
//
//  Created by Артем Билый on 26.10.2022.
//

import UIKit
import Kingfisher

final class SearchMovieCell: UITableViewCell {
    //MARK: - cell identifier
    static let cellIdentifier = "SearchResultTableViewCell"
    
    //MARK: - MovieCell UI Elements
    private let container = UIView()
    private let posterImage = UIImageView()
    private let title = UILabel()
    private let saveButton = UIButton(type: .custom)
    private let voteAverage = UILabel()
    private let star = UIImageView()
    private let overview = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContraints()
    }
    
    //MARK: - ConfigureCell
    private func configureView() {
        contentView.addSubview(posterImage)
        contentView.addSubview(title)
        contentView.addSubview(saveButton)
        contentView.addSubview(overview)
        contentView.addSubview(star)
        contentView.addSubview(voteAverage)

        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.contentMode = .scaleAspectFit
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        title.textAlignment = .left
        title.textColor = .black
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.adjustsFontForContentSizeCategory = true
        
        star.translatesAutoresizingMaskIntoConstraints = false
        star.contentMode = .scaleAspectFit
        star.image = UIImage(named: "star")
        
        saveButton.setImage(UIImage(named: "addwatchlist"), for: .normal)
        saveButton.setImage(UIImage(named: "checkmark"), for: .selected)
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        voteAverage.font = UIFont.systemFont(ofSize: 12)
        voteAverage.textColor = .black
        voteAverage.translatesAutoresizingMaskIntoConstraints = false
        
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.numberOfLines = 7
        overview.textAlignment = .left
        overview.adjustsFontForContentSizeCategory = true
        overview.font = UIFont.systemFont(ofSize: 14)
        overview.textColor = .systemGray
    }
    //MARK: - MovieCell Contraints
    private func setupContraints() {
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterImage.widthAnchor.constraint(equalToConstant: 130)
        ])

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            title.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: posterImage.topAnchor, constant: 3),
            saveButton.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 38),
            saveButton.widthAnchor.constraint(equalToConstant: 32)
        ])

        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            overview.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            overview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            overview.bottomAnchor.constraint(equalTo: star.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            star.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16),
            star.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            star.heightAnchor.constraint(equalToConstant: 16),
            star.widthAnchor.constraint(equalToConstant: 16)
            ])

        NSLayoutConstraint.activate([
            voteAverage.leadingAnchor.constraint(equalTo: star.trailingAnchor, constant: 4),
            voteAverage.centerYAnchor.constraint(equalTo: star.centerYAnchor)
        ])
//        overview.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .vertical)
//        star.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        
    }
    //MARK: - Test Kingfisher
    func bindWithViewMovie(movie: MoviesModel.Movie) {
        title.text = movie.title
        voteAverage.text = "\(movie.voteAverage)"
        overview.text = movie.overview
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        posterImage.kf.setImage(with: url)
    }
    
    func bindWithViewTVShow(tvShow: TVShowsModel.TVShow) {
        title.text = tvShow.name
        voteAverage.text = "\(tvShow.voteAverage)"
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(tvShow.posterPath ?? "")")
        posterImage.kf.setImage(with: url)
    }
    
    //MARK: - Select for save/delete item
    @objc func saveButtonPressed() {
        saveButton.isSelected.toggle()
    }
}
