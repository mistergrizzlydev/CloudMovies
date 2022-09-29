//
//  PopularMovieCell.swift
//  PopCornCine
//
//  Created by Артем Билый on 29.09.2022.
//
//
//  ShouldDelete.swift
//  SplashScreenTest
//
//  Created by Артем Билый on 24.09.2022.
//

import UIKit
import Kingfisher

final class MovieCell: UICollectionViewCell {
    
    static let cellIdentifier = "cellIdentifier"
    
    //MARK: UI
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
    //MARK: - ConfigureCell
    private func configureView() {
        container.translatesAutoresizingMaskIntoConstraints = false
        container.contentMode = .scaleAspectFill
        container.clipsToBounds = true
//        container.layer.cornerRadius = container.bounds.height / 2
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.clipsToBounds = true
        posterImage.contentMode = .scaleAspectFit
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textAlignment = .center
        title.adjustsFontForContentSizeCategory = true
        title.font = UIFont.preferredFont(forTextStyle: .caption2)
        
        contentView.addSubview(container)
        container.addSubview(posterImage)
        contentView.addSubview(title)
        
        container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        posterImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        posterImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        title.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 4).isActive = true
//        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        container.dropShadow()
    }
    //MARK: - Kingfisher check
    func bindWithView(viewModel: MovieViewModel) {
        let movie = viewModel.movie
        title.text = movie.title
        let url = URL(string: movie.posterURL)
        posterImage.kf.setImage(with: url)
    }
}
