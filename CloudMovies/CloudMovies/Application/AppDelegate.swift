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
    private let authorizationVC = AuthorizationViewController()
    private let onboardingViewController = OnboardingContainerViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        splashPresenter?.present()
        onboardingViewController.delegate = self
        authorizationVC.delegate = self
        //logout delegate
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
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(onboardingViewController)
        } else {
            setRootViewController(tabBarContoller)
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
