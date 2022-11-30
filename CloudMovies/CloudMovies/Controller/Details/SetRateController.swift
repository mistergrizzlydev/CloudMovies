//
//  SetRateController.swift
//  CloudMovies
//
//  Created by Artem Bilyi on 17.11.2022.
//

import UIKit
import Cosmos

final class SetRateController: UIViewController {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    // Cosmos
    lazy var cosmosView: CosmosView = {
        let cosmos = CosmosView()
        cosmos.settings.updateOnTouch = true
        cosmos.settings.totalStars = 10
        cosmos.settings.starSize = 25
        cosmos.settings.starMargin = 3.3
        cosmos.settings.fillMode = .full
        cosmos.rating = 0
        cosmos.settings.textMargin = 10
        cosmos.translatesAutoresizingMaskIntoConstraints = false
        return cosmos
    }()
    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    lazy var posterView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.dropShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var blur: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var setRateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Rate", for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .systemRed
        button.backgroundColor = .darkGray
        button.dropShadow()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var mediaType: MediaType?
    var mediaID: Int = 0
    private var rate: Double = 0.0
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    // Constraints
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        backgroundView.frame = view.bounds
        blur.frame = view.bounds
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            cosmosView.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 24),
            cosmosView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            posterView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.6),
            posterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posterView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(view.frame.height / 7))
        ])
        NSLayoutConstraint.activate([
            setRateButton.topAnchor.constraint(equalTo: cosmosView.topAnchor, constant: view.frame.height * 0.1),
            setRateButton.widthAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1),
            setRateButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            setRateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backgroundView)
        backgroundView.addSubview(blur)
        view.addSubview(posterView)
        view.addSubview(cosmosView)
        view.addSubview(dismissButton)
        view.addSubview(setRateButton)
        self.cosmosView.didTouchCosmos = { rating in
            self.rate = rating
        }
        dismissButton.addAction(UIAction {_ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        setRateButton.addTarget(self, action: #selector(chooseStar), for: .touchUpInside)
    }
    // MARK: Delete session
    @objc func chooseStar() {
        
        if let sessionID = StorageSecure.keychain["sessionID"] {
            networkManager.rateMedia(mediaType: mediaType!.rawValue,
                                     mediaID: String(mediaID),
                                     sessionID: sessionID,
                                     guestID: "",
                                     value: rate)
        print("done")
        }
        if let guestID = StorageSecure.keychain["guestID"] {
            networkManager.rateMedia(mediaType: mediaType!.rawValue,
                                     mediaID: String(mediaID),
                                     sessionID: "",
                                     guestID: guestID,
                                     value: rate)
        print("done")
        }
        self.dismiss(animated: true)
    }
    
}
