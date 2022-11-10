//
//  AuthorizationViewController.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit
import Lottie
import SafariServices
// replace to another vc later
protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

final class LoginViewController: UIViewController {
    // MARK: - Init UI
    private let backgroundAnimation = AnimationView.init(name: "background")
    private let welcomeLabel = UILabel()
    private let instructionLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private var signInButton = UIButton(type: .system)
    private let signUpButton = UIButton(type: .system)
    private let signUpURL = "https://www.themoviedb.org/signup"
    private let forgetPasswordURL = "https://www.themoviedb.org/reset-password"
    private let forgetPasswordButton = UIButton(type: .system)
    private let errorMessageLabel = UILabel()
    private let loginView = LoginView()
    private let guestButton = UIButton(type: .system)
    private var buttonAction = false {
        didSet {
            signInButton.setNeedsUpdateConfiguration()
        }
    }
    // loginViewModel
    lazy var viewModel = LoginViewModel()
    // delegate
    weak var delegate: LoginViewControllerDelegate?
    // for textfield field
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }
    // MARK: - Life cycle
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
}

extension LoginViewController {
    // MARK: - Setup UI
    private func setupUI() {
        backgroundAnimation.contentMode = .scaleAspectFill
        backgroundAnimation.animationSpeed = 1
        backgroundAnimation.loopMode = .loop
        backgroundAnimation.play()
        backgroundAnimation.translatesAutoresizingMaskIntoConstraints = false
        // welcomeLabel
        welcomeLabel.text = "CloudMovies"
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .left
        welcomeLabel.adjustsFontForContentSizeCategory = true
        welcomeLabel.minimumContentSizeCategory = .accessibilityLarge
        welcomeLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        // same
        instructionLabel.text = "Designed to find your\n\t\t\tmovies and TV Shows - match"
        instructionLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        instructionLabel.numberOfLines = 2
        instructionLabel.textAlignment = .left
        instructionLabel.adjustsFontForContentSizeCategory = true
        instructionLabel.minimumContentSizeCategory = .accessibilityMedium
        instructionLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        // title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.minimumContentSizeCategory = .accessibilityExtraLarge
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = ""
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        // subtitle
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .black
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Sign in to Continue"
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        // login view textfieldls
        loginView.translatesAutoresizingMaskIntoConstraints = false
        // error message
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.adjustsFontForContentSizeCategory = true
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        // guestButton
        guestButton.titleLabel?.textAlignment = .right
        guestButton.tintColor = .black
        guestButton.adjustsImageSizeForAccessibilityContentSizeCategory = true
        guestButton.setTitle("continue as Guest", for: .normal)
        guestButton.titleLabel?.alpha = 0.6
        guestButton.addTarget(self, action: #selector(continueAsGuest), for: .touchUpInside)
        guestButton.translatesAutoresizingMaskIntoConstraints = false
        // MARK: Sign In action
        signInButton.addAction(
            UIAction { _ in
                self.errorMessageLabel.isHidden = true
                self.buttonAction = true
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [self] _ in
                    guard let username = username, let password = password else { return }
                    viewModel.makeAuthentication(username: username, password: password) { [self] result in
                        if username.isEmpty || password.isEmpty {
                            self.shakeButton()
                            self.configureView(withMessage: "Username / password cannot be blank")
                            return
                        } else {
                            if result != true {
                                self.shakeButton()
                                self.configureView(withMessage: "Incorrect username / password")
                            } else {
                                viewModel.getAccountID(sessionID: self.viewModel.sessionID)
                                self.signInButton.configuration?.showsActivityIndicator = true
                                self.delegate?.didLogin()
                            }
                        }
                    }
                    self.buttonAction = false
                }
            },
            for: .touchUpInside
        )
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .large
        config.imagePlacement = .trailing
        config.imagePadding = 8
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .subheadline)
            return outgoing
        }
        signInButton.configuration = config
        signInButton.configurationUpdateHandler = { [unowned self] button in
            var config = button.configuration
            config?.title = self.buttonAction ? "Signing in..." : "Sign In"
            button.isEnabled = !self.buttonAction
            if self.buttonAction == true {
                config?.showsActivityIndicator = self.buttonAction
                config?.background.backgroundColor = .lightGray
                button.configuration = config
            } else {
                config?.showsActivityIndicator = self.buttonAction
                config?.background.backgroundColor = .systemRed
                button.configuration = config
            }
        }
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.dropShadow()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        // register
        signUpButton.titleLabel?.adjustsFontForContentSizeCategory = true
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14)
        signUpButton.titleLabel?.adjustsFontForContentSizeCategory = true
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.addTarget(self, action: #selector(singUpPressed), for: .primaryActionTriggered)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        // forget
        forgetPasswordButton.titleLabel?.font = .systemFont(ofSize: 14)
        forgetPasswordButton.tintColor = .black
        forgetPasswordButton.titleLabel?.alpha = 0.6
        forgetPasswordButton.titleLabel?.adjustsFontForContentSizeCategory = true
        forgetPasswordButton.setTitle("Forgot password?", for: .normal)
        forgetPasswordButton.addTarget(self, action: #selector(forgetPressed), for: .primaryActionTriggered)
        forgetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
    }
    // MARK: - Setup Layout
    func setupLayout() {
        view.addSubview(backgroundAnimation)
        view.addSubview(welcomeLabel)
        view.addSubview(instructionLabel)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(guestButton)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        view.addSubview(forgetPasswordButton)
        view.addSubview(signUpButton)
        // welcome
        NSLayoutConstraint.activate([
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120)
        ])
        // next label
        NSLayoutConstraint.activate([
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            instructionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 4),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        // title
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        // backgroundPanda
        NSLayoutConstraint.activate([
            backgroundAnimation.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor),
            backgroundAnimation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundAnimation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundAnimation.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor)
        ])
        // subtitle
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 1),
            subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        // login view
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width * 0.10),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(view.frame.width * 0.10))
        ])
        // guestButton
        NSLayoutConstraint.activate([
            guestButton.topAnchor.constraint(equalTo: loginView.bottomAnchor),
            guestButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        // sign in button
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.heightAnchor.constraint(equalTo: welcomeLabel.heightAnchor, multiplier: 1),
            signInButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.6),
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 4)
        ])
        // error message
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 3),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        // sign out button
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 8),
            signUpButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
            //            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        // forger password
        NSLayoutConstraint.activate([
            forgetPasswordButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 8),
            forgetPasswordButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor)
        ])
    }
    // MARK: Configure Error Label appearence
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    // MARK: Continue action as guest
    @objc func continueAsGuest() {
        viewModel.getGuestSessionID()
        delegate?.didLogin()
    }
    // MARK: Forget password action
    @objc func forgetPressed(sender: UIButton) {
        guard let url = URL(string: forgetPasswordURL) else { return }
        let config = SFSafariViewController.Configuration()
        let webVC = SFSafariViewController(url: url, configuration: config)
        present(webVC, animated: true)
    }
    // MARK: Sign Up action
    @objc func singUpPressed(sender: UIButton) {
        guard let url = URL(string: signUpURL) else { return }
        let config = SFSafariViewController.Configuration()
        let webVC = SFSafariViewController(url: url, configuration: config)
        present(webVC, animated: true)
    }
    // MARK: Animation
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.1, 0.5, 0.83, 1]
        animation.duration = 0.5
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
    // MARK: - Keyboard Setup
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    // dismiss keyboard by tap
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    // selector for dismiss
    private func setupKeyboardHiding() {
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        //        view.frame.origin.y = view.frame.origin.y - 80
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
