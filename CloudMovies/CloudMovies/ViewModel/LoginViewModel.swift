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
        
    func tryToMakeThisShit(login: String, password: String, completion: @escaping((Bool) -> ())) {
        networkManager.getRequestToken { result in
            self.networkManager.validateWithLogin(login: login, password: password, requestToken: result.requestToken ?? "") { result in
                print(result)
                self.networkManager.createSession(requestToken: result.requestToken ?? "") { result in
                    print(result)
                    completion(result.success!)
                }
            }
        }
    }
}
