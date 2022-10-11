//
//  AuthorizationViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit
import Lottie
import SafariServices

final class AuthorizationViewController: UIViewController {
    //MARK: UI Elements
    private let backgroundAnimation = AnimationView.init(name: "background")
    private let welcomeLabel = UILabel()
    private let instructionLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let signInButton = UIButton(type: .system)
    private let signUpButton = UIButton(type: .system)
    private let signUpURL = "https://www.themoviedb.org/signup"
    private let forgetPasswordURL = "https://www.themoviedb.org/reset-password"
    private let forgetPasswordButton = UIButton(type: .system)
    private let errorMessageLabel = UILabel()
    private let loginView = LoginView()
    //textfield field
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
    }
    override func viewWillLayoutSubviews() {
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backgroundAnimation.play()
    }
    
    deinit {
        removeNotification()
    }
}

//MARK: - Setup UI & layout
extension AuthorizationViewController {
    private func setupUI() {
        backgroundAnimation.contentMode = .scaleAspectFill
        backgroundAnimation.animationSpeed = 1
        backgroundAnimation.loopMode = .loop
        backgroundAnimation.play()
        backgroundAnimation.translatesAutoresizingMaskIntoConstraints = false
        //welcomeLabel
        welcomeLabel.text = "CloudMovies"
        welcomeLabel.textColor = .white
        welcomeLabel.textAlignment = .left
        welcomeLabel.adjustsFontForContentSizeCategory = true
        welcomeLabel.minimumContentSizeCategory = .accessibilityLarge
        welcomeLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        //same
        instructionLabel.text = "Designed to find your movie-match"
        instructionLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        instructionLabel.numberOfLines = 1
        instructionLabel.textAlignment = .left
        instructionLabel.adjustsFontForContentSizeCategory = true
        instructionLabel.minimumContentSizeCategory = .accessibilityMedium
        instructionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        //title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.minimumContentSizeCategory = .accessibilityExtraLarge
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = ""
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        //subtitle
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Sign in to Continue"
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        //login view textfieldls
        loginView.translatesAutoresizingMaskIntoConstraints = false
        //error message
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.adjustsFontForContentSizeCategory = true
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        //sign in button
        /*
         make sizefont better
         */
        signInButton.backgroundColor = #colorLiteral(red: 0.3952207565, green: 0.460826695, blue: 0.7956546545, alpha: 1)
        signInButton.tintColor = .white
        signInButton.configuration = .plain() // ?
        signInButton.configuration?.imagePlacement = .trailing
        signInButton.configuration?.imagePadding = 16
        signInButton.layer.cornerRadius = 18
        //        signInButton.titleLabel?.font = .systemFont(ofSize: 60)
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.addTarget(self, action: #selector(signInPressed), for: .primaryActionTriggered)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        //register
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14)
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.addTarget(self, action: #selector(singUpPressed), for: .primaryActionTriggered)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        //forget
        forgetPasswordButton.titleLabel?.font = .systemFont(ofSize: 14)
        forgetPasswordButton.tintColor = .white
        forgetPasswordButton.setTitle("Forgot password?", for: .normal)
        forgetPasswordButton.addTarget(self, action: #selector(forgetPressed), for: .primaryActionTriggered)
        forgetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayout() {
        view.addSubview(backgroundAnimation)
        view.addSubview(welcomeLabel)
        view.addSubview(instructionLabel)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        view.addSubview(forgetPasswordButton)
        view.addSubview(signUpButton)
        //background
        NSLayoutConstraint.activate([
            backgroundAnimation.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundAnimation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundAnimation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundAnimation.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        //title
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        //subtitle
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 1),
            subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        //login view
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        //sign in button
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.heightAnchor.constraint(equalTo: welcomeLabel.heightAnchor, multiplier: 1),
            signInButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.3),
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 4)
        ])
        // error message
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        //sign out button
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 8),
            signUpButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
            //            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        //forger password
        NSLayoutConstraint.activate([
            forgetPasswordButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 8),
            forgetPasswordButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor)
        ])
    }
    
    @objc func signInPressed(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "Artem" && password == "qwerty" {
            signInButton.configuration?.showsActivityIndicator = true
            self.dismiss(animated: true)
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
    @objc func forgetPressed(sender: UIButton) {
        guard let url = URL(string: forgetPasswordURL) else { return }
        let config = SFSafariViewController.Configuration()
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
    @objc func singUpPressed(sender: UIButton) {
        guard let url = URL(string: signUpURL) else { return }
        let config = SFSafariViewController.Configuration()
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
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
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
            view.frame.origin.y = view.frame.origin.y - 80
        }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
