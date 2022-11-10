//
//  DetailsMediaView.swift
//  CloudMovies
//
//  Created by Артем Билый on 09.11.2022.
//

import UIKit
import WebKit

final class VideoCell: UICollectionViewCell, WKUIDelegate {
    // MARK: identifier
    static let identifier = "videoCell"
    // MARK: - MovieCell UI Elements
    var container = UIView()
    var color = UIColor()
    var webPlayer = WKWebView()
    
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
         webPlayer.uiDelegate = self
         webPlayer.allowsBackForwardNavigationGestures = true
         webPlayer.allowsLinkPreview = true
        container.translatesAutoresizingMaskIntoConstraints = false
    }
    // MARK: - Contraints
    private func setupContraints() {
        NSLayoutConstraint.activate([
            container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    // MARK: - Configure
    func bindWithMedia(media: YoutubeModel.Video) {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        DispatchQueue.main.async {
            self.webPlayer = WKWebView(frame: self.container.bounds, configuration: webConfiguration)
            self.container.addSubview(self.webPlayer)
            let pathURL = media.key
            guard let videoURL = URL(string: "https://www.youtube.com/embed/\(pathURL)?playsinline=1") else { return }
            let request = URLRequest(url: videoURL)
            self.webPlayer.load(request)
        }
        
    }
}
