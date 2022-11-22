//
//  OverviewFullController.swift
//  CloudMovies
//
//  Created by Artem Bilyi on 18.11.2022.
//

import UIKit

final class OverviewFullController: UIViewController {
    private let container = UIView()
    private let textView = UITextView()
    // init param
    init(overview: String) {
        self.textView.text = overview
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layout()
    }
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.textContainer.maximumNumberOfLines = 0
        textView.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        textView.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        container.addSubview(textView)
    }
    // MARK: - Constraints
    private func layout() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: container.topAnchor, constant: 24),
            textView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}
