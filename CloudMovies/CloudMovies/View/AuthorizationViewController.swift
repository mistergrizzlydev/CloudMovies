//
//  AuthorizationViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit
import Lottie

class AuthorizationViewController: UIViewController {
    //MARK: UI Elements
    private let welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome"
        welcomeLabel.textColor = .white
        welcomeLabel.textAlignment = .left
        welcomeLabel.adjustsFontForContentSizeCategory = true
        welcomeLabel.minimumContentSizeCategory = .accessibilityExtraExtraLarge
        welcomeLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        return welcomeLabel
    }()
    private let instructionLabel: UILabel = {
        let instructionLabel = UILabel()
        instructionLabel.text = "Sign in to Continue"
        instructionLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        instructionLabel.numberOfLines = 1
        instructionLabel.textAlignment = .left
        instructionLabel.adjustsFontForContentSizeCategory = true
        instructionLabel.minimumContentSizeCategory = .accessibilityLarge
        instructionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        return instructionLabel
    }()
    private let enterButton: UIButton = {
        let enterButton = UIButton(type: .system)
        enterButton.backgroundColor = #colorLiteral(red: 0.3952207565, green: 0.460826695, blue: 0.7956546545, alpha: 1)
        enterButton.tintColor = .white
        //        enterButton.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        enterButton.layer.cornerRadius = 18
        enterButton.titleLabel?.font = .systemFont(ofSize: 24)
        enterButton.setTitle("Sign in", for: .normal)
        return enterButton
    }()
    private let registerButton: UIButton = {
        let registerButton = UIButton(type: .system)
        registerButton.titleLabel?.font = .systemFont(ofSize: 14)
        registerButton.setTitle("Sign up", for: .normal)
        return registerButton
    }()
    private lazy var forgetPasswordButton: UIButton = {
        let forgetPasswordButton = UIButton(type: .system)
        forgetPasswordButton.titleLabel?.font = .systemFont(ofSize: 14)
        forgetPasswordButton.tintColor = .white
        forgetPasswordButton.setTitle("Forget password?", for: .normal)
        return forgetPasswordButton
    }()
    private lazy var backgroundAnimatiom: AnimationView = {
        let background = AnimationView.init(name: "background")
        background.contentMode = .scaleAspectFill
        background.animationSpeed = 1
        background.loopMode = .loop
        background.play()
        return background
    }()
    
    private let passwordTextField = PasswordTextField(placeHolderText: "New password")
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
    }
    override func viewWillLayoutSubviews() {
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundAnimatiom.play()
    }
}

//MARK: - Setup UI & layout
extension AuthorizationViewController {
    private func setupUI() {
        backgroundAnimatiom.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundAnimatiom)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionLabel)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        //        view.addSubview(passwordTextField)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(enterButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        forgetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forgetPasswordButton)
    }
    
    func setupConstraints() {
        //background
        NSLayoutConstraint.activate([
            backgroundAnimatiom.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundAnimatiom.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundAnimatiom.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundAnimatiom.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        //welcome
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160)
        ])
        //next label
        NSLayoutConstraint.activate([
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            instructionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 4)
        ])
        
        //        NSLayoutConstraint.activate([
        //            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        //            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        //            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        //            passwordTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        //
        //        ])
        //sign in button
        NSLayoutConstraint.activate([
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.heightAnchor.constraint(equalTo: welcomeLabel.heightAnchor, multiplier: 1),
            enterButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.3),
            enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 4)
        ])
        //sign out button
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 8),
            registerButton.trailingAnchor.constraint(equalTo: enterButton.trailingAnchor)
            //            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        //forger password
        NSLayoutConstraint.activate([
            forgetPasswordButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 8),
            forgetPasswordButton.leadingAnchor.constraint(equalTo: enterButton.leadingAnchor)
        ])
    }
    //MARK: - Keyboard Apperance Setup
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        view.frame.origin.y = view.frame.origin.y - view.frame.height / 4
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
