//
//  MovieCell.swift
//  CloudMovies
//
//  Created by Артем Билый on 20.10.2022.
//

import UIKit
import Kingfisher

final class MediaCell: UICollectionViewCell {
    // MARK: identifier
    static let identifier = "cellIdentifier"
    // MARK: - MovieCell UI Elements
    private let contrainer = UIView()
    private let posterImage = UIImageView()
    private let title = UILabel()
    private let saveButton = UIButton(type: .custom)
    private let voteAverage = UILabel()
    private let star = UIImageView()
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    weak var delegate: ViewModelProtocol?
    private var mediaID: Int = 0
    private var mediaType: MediaType?
    private lazy var sessionID = UserDefaults.standard.string(forKey: "sessionID")
    private lazy var accountID = UserDefaults.standard.string(forKey: "accountID")
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        hideButton()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented - not using storyboards")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContraints()
    }
    // MARK: - Configure cell
    private func configureView() {
        contrainer.clipsToBounds = true
        contrainer.translatesAutoresizingMaskIntoConstraints = false
        contrainer.contentMode = .scaleAspectFill
        contrainer.backgroundColor = .white
        contrainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        contrainer.layer.cornerRadius = 8
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
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        voteAverage.font = UIFont.preferredFont(forTextStyle: .caption1)
        voteAverage.textColor = .black
        voteAverage.translatesAutoresizingMaskIntoConstraints = false
        contentView.dropShadow()
    }
    // MARK: - MovieCell Contraints
    private func setupContraints() {
        contentView.addSubview(contrainer)
        contrainer.addSubview(title)
        contrainer.addSubview(star)
        contrainer.addSubview(voteAverage)
        contrainer.addSubview(posterImage)
        contrainer.addSubview(saveButton)
        NSLayoutConstraint.activate([
            contrainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            contrainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            contrainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            contrainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contrainer.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: contrainer.trailingAnchor, constant: -8),
            title.bottomAnchor.constraint(equalTo: contrainer.bottomAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            star.leadingAnchor.constraint(equalTo: contrainer.leadingAnchor, constant: 8),
            star.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -4),
            star.heightAnchor.constraint(equalToConstant: 14),
            star.widthAnchor.constraint(equalToConstant: 14)
        ])
        NSLayoutConstraint.activate([
            voteAverage.leadingAnchor.constraint(equalTo: star.trailingAnchor, constant: 4),
            voteAverage.centerYAnchor.constraint(equalTo: star.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contrainer.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contrainer.leadingAnchor),
            posterImage.widthAnchor.constraint(equalTo: contrainer.widthAnchor, multiplier: 1),
            posterImage.heightAnchor.constraint(equalTo: posterImage.widthAnchor, multiplier: 1.5)
        ])
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: contrainer.topAnchor),
            saveButton.leadingAnchor.constraint(equalTo: contrainer.leadingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
    // MARK: - Configure with Kingsfiger
    func bindWithMedia(media: MediaModel.Media) {
        title.text = media.title ?? media.name
        voteAverage.text = "\(media.voteAverage ?? 0.0)"
        guard let poster = media.posterPath else { return }
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)")
        posterImage.kf.indicatorType = .activity
        posterImage.kf.setImage(with: url)
        mediaID = media.id ?? 0
        if media.title != nil {
            mediaType = MediaType.movie
        } else {
            mediaType = MediaType.tvShow
        }
    }
    func hideButton() {
        if sessionID == "" {
            saveButton.isHidden = true
        } else {
            saveButton.isHidden = false
        }
    }
    // MARK: - Select for save/delete item
    @objc func saveButtonPressed(_ sender: UIButton) {
        saveButton.isSelected.toggle()
        switch sender.isSelected {
        case true:
            networkManager.actionWatchList(mediaType: mediaType!.rawValue,
                                           mediaID: String(mediaID),
                                           bool: true,
                                           accountID: accountID!,
                                           sessionID: sessionID!)
        case false:
            networkManager.actionWatchList(mediaType: mediaType!.rawValue,
                                           mediaID: String(mediaID),
                                           bool: false,
                                           accountID: accountID!,
                                           sessionID: sessionID!)
        }
    }
}
