//
//  OnboardingViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 24.10.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
// MARK: - Init UI
    let imageTop = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let topImage: String
    let titleText: String
    let descriptionText: String
    let color: UIColor
    // reusable
    init(topImage: String, titleText: String, descriptionText: String, color: UIColor) {
        self.topImage = topImage
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
        view.backgroundColor = color
        // label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0
        titleLabel.text = titleText
        // description
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = descriptionText
        // image
        imageTop.translatesAutoresizingMaskIntoConstraints = false
        imageTop.contentMode = .scaleAspectFit
    }
// MARK: - Layout
    func layout() {
        view.addSubview(imageTop)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            imageTop.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.10),
            imageTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.10),
            imageTop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * 0.10)),
            imageTop.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageTop.bottomAnchor, constant: view.frame.width * 0.10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * 0.10))
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * 0.10)
        ])
    }
}
