//
//  AuthorizationViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit
import Lottie

class AuthorizationViewController: UIViewController {
    
    private lazy var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome"
        welcomeLabel.numberOfLines = 1
        welcomeLabel.textAlignment = .left
        welcomeLabel.adjustsFontForContentSizeCategory = true
        welcomeLabel.minimumContentSizeCategory = .accessibilityLarge
        welcomeLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        return welcomeLabel
    }()
    private lazy var instructionLabel: UILabel = {
        let instructionLabel = UILabel()
        instructionLabel.text = "Sign in to Continue"
        instructionLabel.numberOfLines = 1
        instructionLabel.textAlignment = .left
        instructionLabel.adjustsFontForContentSizeCategory = true
        instructionLabel.minimumContentSizeCategory = .accessibilityMedium
        instructionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        return instructionLabel
    }()
    
    private lazy var usernameTextField: UITextField = {
        let usernameTextField = UITextField()
        usernameTextField.backgroundColor = .systemOrange
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        usernameTextField.attributedText = NSAttributedString(string: "username")
        return usernameTextField
    }()
    private lazy var wrongUsernameLabel: UILabel = {
        let wrongUsernameLabel = UILabel()
        wrongUsernameLabel.alpha = 1 //make it invisiable
        wrongUsernameLabel.textColor = .systemRed
        wrongUsernameLabel.textAlignment = .left
        wrongUsernameLabel.text = "wrong username"
        return wrongUsernameLabel
    }()
    private lazy var passwordTexField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.backgroundColor = .systemCyan
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.attributedText = NSAttributedString(string: "username")
        return passwordTextField
    }()
    private lazy var wrongPasswordLabel: UILabel = {
        let wrongPasswordLabel = UILabel()
        wrongPasswordLabel.alpha = 1 //make it invisiable
        wrongPasswordLabel.textColor = .systemRed
        wrongPasswordLabel.textAlignment = .left
        wrongPasswordLabel.text = "wrong password"
        return wrongPasswordLabel
    }()
    private lazy var enterButton: UIButton = {
        let enterButton = UIButton(type: .system)
        enterButton.backgroundColor = .systemGray
        enterButton.setTitle("Sign in", for: .normal)
        return enterButton
    }()
    private let registerButton: UIButton = {
        let registerButton = UIButton(type: .system)
        registerButton.backgroundColor = .systemPink
        registerButton.setTitle("Sign up", for: .normal)
        return registerButton
    }()
    private lazy var forgetPasswordButton: UIButton = {
        let forgetPasswordButton = UIButton(type: .system)
        forgetPasswordButton.setTitle("Forget password", for: .normal)
        return forgetPasswordButton
    }()
    
    private let backgroundAnimatiom = AnimationView.init(name: "background")
    private let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    private let stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillLayoutSubviews() {
        setupConstraints()
        style()
        layout()
    }
    
    private func setupUI() {
        backgroundAnimatiom.animationSpeed = 0.5
        backgroundAnimatiom.loopMode = .loop
        backgroundAnimatiom.play()
        view.addSubview(backgroundAnimatiom)
        view.addSubview(welcomeLabel)
        view.addSubview(instructionLabel)
        view.addSubview(usernameTextField)
        view.addSubview(wrongUsernameLabel)
        view.addSubview(passwordTexField)
        view.addSubview(wrongPasswordLabel)
        view.addSubview(enterButton)
        view.addSubview(registerButton)
        setupKeyboardHiding()
    }
    
    private func setupConstraints() {
        backgroundAnimatiom.frame = view.bounds
        setupWelcomeLabel()
        setupInstructionLabel()
        setupUsernameTextField()
        setupWrondUsernameLabel()
        setupPasswordTexField()
        setupWrondPasswordLabel()
        setupEnterButton()
        setutpRegisterButton()
    }
    
    private func setupWelcomeLabel() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupInstructionLabel() {
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            instructionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupUsernameTextField() {
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupWrondUsernameLabel() {
        wrongUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrongUsernameLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 4),
            wrongUsernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrongPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupPasswordTexField() {
        passwordTexField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTexField.topAnchor.constraint(equalTo: wrongUsernameLabel.bottomAnchor, constant: 40),
            passwordTexField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            passwordTexField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //            passwordTexField.widthAnchor.constraint(equalToConstant: 400),
            passwordTexField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupWrondPasswordLabel() {
        wrongPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrongPasswordLabel.topAnchor.constraint(equalTo: passwordTexField.bottomAnchor, constant: 4),
            wrongPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrongPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupEnterButton() {
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: wrongPasswordLabel.bottomAnchor, constant: 40),
            enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56),
            enterButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setutpRegisterButton() {
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 32),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56),
            registerButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}


extension AuthorizationViewController {
    
    func style() {
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
    }
    
    func layout() {
        stackView.addArrangedSubview(newPasswordTextField)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
        
        view.addSubview(newPasswordTextField)
        
        NSLayoutConstraint.activate([
            newPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            newPasswordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: newPasswordTextField.trailingAnchor, multiplier: 1),
            newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        view.frame.origin.y = view.frame.origin.y - 200
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
