//
//  AppDelegate.swift
//  CloudMovies
//
//  Created by Артем Билый on 03.10.2022.
//

import UIKit

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    private var splashPresenter: SplashPresenterDescription? = SplashPresenter()
    let authorization = AuthorizationViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = authorization
        splashPresenter?.present()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
            }
        }
        return true
    }
}

