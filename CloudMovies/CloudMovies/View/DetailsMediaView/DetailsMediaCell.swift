//
//  DetailsMediaView.swift
//  CloudMovies
//
//  Created by Артем Билый on 09.11.2022.
//

import UIKit
import YouTubeiOSPlayerHelper

final class VideoCell: UICollectionViewCell {
    // MARK: identifier
    static let identifier = "videoCell"
    // MARK: - MovieCell UI Elements
    var container = UIView()
    lazy var webPlayer = YTPlayerView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
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
    func configureView() {
        contentView.addSubview(container)
        container.addSubview(webPlayer)
    }
    // MARK: - Contraints
    private func setupContraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        webPlayer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            webPlayer.topAnchor.constraint(equalTo: container.topAnchor),
            webPlayer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            webPlayer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            webPlayer.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    // MARK: - Configure
    func bindWithMedia(keysPath: [String], index: Int) {
        DispatchQueue.main.async {
            self.webPlayer.load(withVideoId: keysPath[index])
        }
    }
}
