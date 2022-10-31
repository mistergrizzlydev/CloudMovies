//
//  LoginViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 29.10.2022.
//

import Foundation

class LoginViewModel {
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    func makeAuthentication(username: String, password: String, completion: @escaping((Bool) -> Void)) {
        networkManager.getRequestToken { result in
            guard let token = result.requestToken else { return }
            self.networkManager.validateWithLogin(login: username, password: password, requestToken: token) { result in
                self.networkManager.createSession(requestToken: result.requestToken ?? "") { success in
                    completion(success.success!)
                }
            }
        }
    }
}
