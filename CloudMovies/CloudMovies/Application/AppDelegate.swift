//
//  AppDelegate.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    private let tabBarContoller = TabBarController()
    private let authorizationVC = LoginViewController()
    private let onboardingViewController = OnboardingContainerViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITableView.appearance().tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        splashPresenter?.present()
        onboardingViewController.delegate = self
        authorizationVC.delegate = self
        // logout delegate add
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.rootViewController = authorizationVC
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
            }
        }
        return true
    }
}

extension AppDelegate {
    func setRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            if viewController == onboardingViewController {
                viewController.modalPresentationStyle = .formSheet
            }
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(onboardingViewController)
        } else {
            setRootViewController(onboardingViewController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(tabBarContoller)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(authorizationVC)
    }
}
