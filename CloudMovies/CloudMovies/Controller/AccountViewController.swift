//
//  AccountViewController.swift
//  CloudMovies
//
//  Created by Artem Bilyi on 12.11.2022.
//
import UIKit

protocol AccounViewControllerDelegate: AnyObject {
    func didLogout()
}

final class AccountViewController: UIViewController {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    let logoutButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
    private func setupUI() {
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
        view.addSubview(logoutButton)
    }
    @objc func logout() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    private func layout() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            logoutButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 6)
        ])
    }
}
