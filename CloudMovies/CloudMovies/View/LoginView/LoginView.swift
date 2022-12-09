//
//  LoginView.swift
//  CloudMovies
//
//  Created by Артем Билый on 04.10.2022.
//

import UIKit

final class LoginView: UIView {
    // MARK: - Init UI
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    private let dividerView = UIView()
    private let stackView = UIStackView()
    private let containerPassword = UIView()
    private let secureView = UIButton(type: .custom)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    override func layoutSubviews() {
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    // MARK: - Setup UI
    private func setupUI() {
        // main
        backgroundColor =  #colorLiteral(red: 0.9531050324, green: 0.9531050324, blue: 0.9531050324, alpha: 1)
        layer.cornerRadius = 5
        clipsToBounds = true
        // stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        // username
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.delegate = self
        usernameTextField.keyboardType = .asciiCapable
        usernameTextField.returnKeyType = .done
        usernameTextField.autocapitalizationType = .none
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        // for pswrd textfield && image
        containerPassword.translatesAutoresizingMaskIntoConstraints = false
        // password texfield
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.textColor = .black
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.isSecureTextEntry = true // as default
        passwordTextField.returnKeyType = .done
        // security switch button
        secureView.translatesAutoresizingMaskIntoConstraints = false
        secureView.setImage(UIImage(systemName: "eye.circle")?.withTintColor(.black,
                                                                             renderingMode: .alwaysOriginal),
                            for: .normal)
        secureView.setImage(UIImage(systemName: "eye.slash.circle")?.withTintColor(.black,
                                                                                   renderingMode: .alwaysOriginal),
                            for: .selected)
        secureView.addTarget(self, action: #selector(switchSecureEntry), for: .touchUpInside)
        // divider
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
    }
    // MARK: Password secure && toogle eyeButton
    @objc func switchSecureEntry(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        secureView.isSelected.toggle()
    }
    // MARK: - Setup Layout
    private func setupConstraints() {
        containerPassword.addSubview(passwordTextField)
        containerPassword.addSubview(secureView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(containerPassword)
        addSubview(stackView)
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: containerPassword.topAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: containerPassword.leadingAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: containerPassword.bottomAnchor),
            passwordTextField.trailingAnchor.constraint(equalToSystemSpacingAfter: secureView.trailingAnchor,
                                                        multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            secureView.topAnchor.constraint(equalTo: containerPassword.topAnchor),
            secureView.trailingAnchor.constraint(equalTo: containerPassword.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            usernameTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: usernameTextField.trailingAnchor, multiplier: 1)
        ])
        passwordTextField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        secureView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}
// MARK: - TextField Delegate
extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
