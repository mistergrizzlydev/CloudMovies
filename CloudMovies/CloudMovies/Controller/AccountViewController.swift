//
//  AccountViewController.swift
//  CloudMovies
//
//  Created by Artem Bilyi on 12.11.2022.
//

import UIKit
import SafariServices
import Lottie

protocol AccounViewControllerDelegate: AnyObject {
    func didLogout()
}

final class AccountViewController: UIViewController {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    private let animation = LottieAnimationView.init(name: "swiftlogo")
    private let centralMessage = UILabel()
    private let logoutButton = UIButton(type: .system)
    private let detailButton = UIButton(type: .system)
    private let linkURL = "https://www.linkedin.com/in/alexandr-slobodianiuk/"
    private var sessionID: String {
        get {
            UserDefaults.standard.string(forKey: "sessionID") ?? ""
        }
        set {
            UserDefaults.standard.string(forKey: "sessionID")
        }
    }
    private var guestID: String {
        get {
            UserDefaults.standard.string(forKey: "guestSessionID") ?? ""
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animation.play()
    }

    private func setupUI() {
        //
        animation.contentMode = .scaleAspectFit
        animation.animationSpeed = 0.5
        animation.loopMode = .loop
        //
        centralMessage.textAlignment = .center
        centralMessage.font = UIFont(name: "Arial", size: 24)
        centralMessage.adjustsFontForContentSizeCategory = true
        centralMessage.numberOfLines = 0
        centralMessage.text = "The final project\nof iOS Cource\nby Alexander Slobodianiuk"
        //
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .large
        config.background.backgroundColor = .systemRed
        logoutButton.setTitle("Logout", for: [])
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.configuration = config
        logoutButton.dropShadow()
        logoutButton.addAction(UIAction { _ in
            self.logout()
        }, for: .touchUpInside)
        
        detailButton.setTitle("Details", for: .normal)
        detailButton.setTitleColor(.white, for: .normal)
        detailButton.configuration = config
        detailButton.addTarget(self, action: #selector(detailButtonAction), for: .touchUpInside)
        detailButton.dropShadow()
        view.addSubview(logoutButton)
        view.addSubview(centralMessage)
        view.addSubview(detailButton)
        view.addSubview(animation)
    }
    @objc func logout() {
        let a = UserDefaults.standard.string(forKey: "guestSessionID")
        print("ACcount VC TEST\(a)")
        networkManager.deleteSession(sessionID: a!)
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    @objc func detailButtonAction(sender: UIButton) {
        guard let url = URL(string: linkURL) else { return }
        let config = SFSafariViewController.Configuration()
        let webVC = SFSafariViewController(url: url, configuration: config)
        present(webVC, animated: true)
    }
    private func layout() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            logoutButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 6)
        ])
        centralMessage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centralMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            centralMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            centralMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centralMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        animation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animation.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 4),
            animation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animation.bottomAnchor.constraint(equalTo: centralMessage.topAnchor, constant: -24)
        ])
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            detailButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            detailButton.topAnchor.constraint(equalTo: centralMessage.bottomAnchor, constant: 16)
        ])
    }
}
