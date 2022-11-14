//
//  OnboardingViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 24.10.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - Init UI
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let topImage = UIImageView()
    let imageName: String
    let titleText: String
    let descriptionText: String
    let color: UIColor
    // reusable
    init(topImage: String, titleText: String, descriptionText: String, color: UIColor) {
        self.imageName = topImage
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.color = color
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented - not using storyboards")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillLayoutSubviews() {
        layout()
    }
}

extension OnboardingViewController {
// MARK: - Setup UI
    func setup() {
        self.modalPresentationStyle = .fullScreen
        view.backgroundColor = color
        // label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.text = titleText
        // description
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.numberOfLines = 7
        descriptionLabel.text = descriptionText
        // image
        topImage.translatesAutoresizingMaskIntoConstraints = false
        topImage.image = UIImage(named: imageName)
        topImage.contentMode = .scaleAspectFit
    }
// MARK: - Layout
    func layout() {
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(topImage)
        NSLayoutConstraint.activate([
            topImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(view.frame.midY / 4)),
            topImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            topImage.widthAnchor.constraint(equalTo: topImage.heightAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: view.frame.width * 0.1),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
