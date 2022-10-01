//
//  ScrollView.swift
//  PopCornCine
//
//  Created by Артем Билый on 01.10.2022.
//

import UIKit

final class DetailView: UIView {
    
    // setting up a scroll view
    // 1. add scrollview
    // 2. add content view
    // 3. add subviews to content view
    // Note: must set high priority of content view to low, default is 1000
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    private lazy var itemTitle: UILabel = {
        let itemTitle = UILabel()
        itemTitle.numberOfLines = 1
        itemTitle.text = "Title"
        itemTitle.textAlignment = .left
        itemTitle.adjustsFontForContentSizeCategory = true
        itemTitle.minimumContentSizeCategory = .accessibilityMedium
        itemTitle.font = UIFont.preferredFont(forTextStyle: .title3)
        itemTitle.backgroundColor = .systemIndigo
        return itemTitle
    }()
    
    private lazy var placeForScrollViewIncludeTrailer: UIView = {
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
        overview.textAlignment = .left
        overview.adjustsFontForContentSizeCategory = true
        overview.text = "Text text text text text text text text text text text text text text Text text text text text text text text text text text text text text Text text text text text text text text text text text text text text Text text text text text text text text text text text text text text Text text text text text text text text text text text text text text"
        overview.minimumContentSizeCategory = .small
        overview.font = UIFont.preferredFont(forTextStyle: .caption1)
        overview.backgroundColor = .systemBlue
        return overview
    }()
    private lazy var addToWatchList: UIButton = {
        let button = UIButton.init(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Watchlist", for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 16
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
//        setupDescriptionLabelConstraints()
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
            itemTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupItemImageViewConstraints() {
        contentView.addSubview(placeForScrollViewIncludeTrailer)
        placeForScrollViewIncludeTrailer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeForScrollViewIncludeTrailer.topAnchor.constraint(equalTo: itemTitle.bottomAnchor),
            placeForScrollViewIncludeTrailer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            placeForScrollViewIncludeTrailer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            placeForScrollViewIncludeTrailer.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupPoster() {
        contentView.addSubview(posterImage)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: placeForScrollViewIncludeTrailer.bottomAnchor, constant: 16),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.45),
            posterImage.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupGenres() {
        contentView.addSubview(genresScrollView)
        genresScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genresScrollView.topAnchor.constraint(equalTo: placeForScrollViewIncludeTrailer.bottomAnchor, constant: 24),
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
            overview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            overview.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 4),
            overview.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.45)
        ])
    }
    
//    private func setupDescriptionLabelConstraints() {
//        contentView.addSubview(descriptionLabel)
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            descriptionLabel.topAnchor.constraint(equalTo: placeForScrollViewIncludeTrailer.bottomAnchor, constant: 20),
//            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
//        ])
//    }
}


//        let margins = view.layoutMarginsGuide
//        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        scrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
//        scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
//        scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
//        scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//        scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//        scrollStackViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//
//        itemTitle.topAnchor.constraint(equalTo: scrollStackViewContainer.topAnchor).isActive = true
//        itemTitle.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor).isActive = true
//        itemTitle.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor).isActive = true
//        itemTitle.bottomAnchor.constraint(equalTo: placeForScrollViewIncludeTrailer.topAnchor).isActive = true
//
//        placeForScrollViewIncludeTrailer.topAnchor.constraint(equalTo: itemTitle.topAnchor).isActive = true
//        placeForScrollViewIncludeTrailer.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor).isActive = true
//        placeForScrollViewIncludeTrailer.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor).isActive = true
//        placeForScrollViewIncludeTrailer.bottomAnchor.constraint(equalTo: posterImage.topAnchor).isActive = true
//
//        posterImage.topAnchor.constraint(equalTo: placeForScrollViewIncludeTrailer.topAnchor, constant: -16).isActive = true
//        posterImage.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 16).isActive = true
//        posterImage.trailingAnchor.constraint(equalTo: genresScrollView.trailingAnchor, constant: 16).isActive = true
//        posterImage.bottomAnchor.constraint(equalTo: addToWatchList.topAnchor, constant: 24).isActive = true
//
//        genresScrollView.topAnchor.constraint(equalTo: placeForScrollViewIncludeTrailer.bottomAnchor, constant: -24).isActive = true
//        genresScrollView.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16).isActive = true
//        genresScrollView.bottomAnchor.constraint(equalTo: overview.topAnchor, constant: 24).isActive = true
//
//        overview.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 16).isActive = true
//        overview.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -16).isActive = true
//        overview.bottomAnchor.constraint(equalTo: addToWatchList.topAnchor, constant: 16).isActive = true
//
//        addToWatchList.trailingAnchor.constraint(equalTo: scrollStackViewContainer.trailingAnchor, constant: -24).isActive = true
//        addToWatchList.leadingAnchor.constraint(equalTo: scrollStackViewContainer.leadingAnchor, constant: 24).isActive = true
//        addToWatchList.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: -16).isActive = true
//        setupUI()
