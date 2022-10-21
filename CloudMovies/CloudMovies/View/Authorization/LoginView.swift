//
//  LoginView.swift
//  CloudMovies
//
//  Created by Артем Билый on 04.10.2022.
//

import UIKit

class LoginView: UIView {
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let dividerView = UIView()
    let stackView = UIStackView()
    let containerPassword = UIView()
    let eyeButton = UIButton(type: .custom)
    
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
    
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.3952207565, green: 0.460826695, blue: 0.7956546545, alpha: 1)
        layer.cornerRadius = 5
        clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.delegate = self
        usernameTextField.keyboardType = .asciiCapable
        usernameTextField.placeholder = "Username"
        
        containerPassword.translatesAutoresizingMaskIntoConstraints = false
        
        passwordTextField.placeholder = "Password"
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.isSecureTextEntry = true //as default
        passwordTextField.delegate = self
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        eyeButton.setImage(UIImage(systemName: "eye.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
    }
    
    func setupConstraints() {
        containerPassword.addSubview(passwordTextField)
        containerPassword.addSubview(eyeButton)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(containerPassword)
        addSubview(stackView)
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: containerPassword.topAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: containerPassword.leadingAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: containerPassword.bottomAnchor),
            passwordTextField.trailingAnchor.constraint(equalToSystemSpacingAfter: eyeButton.trailingAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            eyeButton.topAnchor.constraint(equalTo: containerPassword.topAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: containerPassword.trailingAnchor)
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
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {  //add more logic
            return true
        } else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        return updatedText.count <= 32
    }
    //MARK: - Toogle Eye
    @objc func togglePasswordView(_ sender: Any) {
        passwordTextField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
}
