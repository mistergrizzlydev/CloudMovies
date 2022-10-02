//
//  ScrollView.swift
//  PopCornCine
//
//  Created by Артем Билый on 01.10.2022.
//

import UIKit

final class DetailsScrollView: UIView {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    public lazy var itemTitle: UILabel = {
        let itemTitle = UILabel()
        itemTitle.numberOfLines = 1
        itemTitle.text = "Title Title Title"
        itemTitle.textAlignment = .left
        itemTitle.adjustsFontForContentSizeCategory = true
        itemTitle.minimumContentSizeCategory = .accessibilityMedium
        itemTitle.font = UIFont.preferredFont(forTextStyle: .title3)
        itemTitle.backgroundColor = .systemIndigo
        return itemTitle
    }()
    
    private lazy var youtubeScrollView: UIView = {
        let scrollView = UIView()
        scrollView.backgroundColor = .systemRed
        return scrollView     // make it ScrollView
    }()
    private lazy var posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.contentMode = .scaleAspectFill
        posterImage.backgroundColor = .systemGreen
        return posterImage
    }()
    
    private lazy var genresScrollView: UILabel = {
        //dont forget make it ScrollView
        let genres = UILabel()
        genres.numberOfLines = 1
        genres.textAlignment = .left
        genres.adjustsFontForContentSizeCategory = true
        genres.minimumContentSizeCategory = .small
        genres.font = UIFont.preferredFont(forTextStyle: .caption2)
        genres.backgroundColor = .systemPink
        return genres
    }()
    private lazy var overview: UILabel = {
        let overview = UILabel()
        overview.translatesAutoresizingMaskIntoConstraints = false
        overview.numberOfLines = 0
        overview.textAlignment = .center
        overview.adjustsFontForContentSizeCategory = true
        overview.text = "Text text text text text text text text text text text text text text Text text text text text text text text text text text text text text Text text text text text text text text text text text text text text Text text text text text text text text text text text text text text Text text text text text text text text text text text text text text"
        overview.minimumContentSizeCategory = .small
        overview.font = UIFont.preferredFont(forTextStyle: .caption1)
        overview.backgroundColor = .systemBlue
        return overview
    }()
    private lazy var addToWatchList: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("Add to Watchlist", for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 6
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupScrollViewContstraints()
        setupContentViewConstraints()
        setupTitle()
        setupItemImageViewConstraints()
        setupPoster()
        setupGenres()
        setupOverview()
        setupAddWatchList()
    }
    
    private func setupScrollViewContstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    private func setupContentViewConstraints() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            heightConstraint
        ])
    }
    
    private func setupTitle() {
        contentView.addSubview(itemTitle)
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemTitle.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.1)
        ])
    }
    
    private func setupItemImageViewConstraints() {
        contentView.addSubview(youtubeScrollView)
        youtubeScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            youtubeScrollView.topAnchor.constraint(equalTo: itemTitle.bottomAnchor),
            youtubeScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            youtubeScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            youtubeScrollView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupPoster() {
        contentView.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: youtubeScrollView.bottomAnchor, constant: 16),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.45),
            posterImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupGenres() {
        contentView.addSubview(genresScrollView)
        genresScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genresScrollView.topAnchor.constraint(equalTo: youtubeScrollView.bottomAnchor, constant: 24),
            genresScrollView.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor),
            genresScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            genresScrollView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1)
        ])
    }
    
    private func setupOverview() {
        contentView.addSubview(overview)
        overview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overview.topAnchor.constraint(equalTo: genresScrollView.bottomAnchor),
            overview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            overview.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 4),
            overview.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.35)
        ])
    }
    
    private func setupAddWatchList() {
        contentView.addSubview(addToWatchList)
        addToWatchList.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToWatchList.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 4),
            addToWatchList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addToWatchList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            addToWatchList.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1)
        ])
    }
}
