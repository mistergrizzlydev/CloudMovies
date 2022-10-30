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
    
    private(set) var requestToken: String = ""
    
    
    func getRequestToken() {
        networkManager.getRequestToken { result in
            DispatchQueue.main.async {
                self.requestToken = result.requestToken
                print("getRequestToken \(self.requestToken)")
            }
        }
    }
    
    func tryToMakeThisShit(login: String, password: String) {
        networkManager.getRequestToken { result in
            DispatchQueue.main.async {
                self.requestToken = result.requestToken
                self.networkManager.validateWithLogin(login: login, password: password, requestToken: result.requestToken) { result in
                    print(result)
                }
            }
        }
    }
    
    
    func validate(login: String, password: String, requestToken: String) {
        networkManager.validateWithLogin(login: login, password: password, requestToken: requestToken) { result in
            DispatchQueue.main.async {
                print("validateWithLogin \(requestToken)")
                print("ValidateWithLogin \(result)")
            }
        }
    }
}
//        networkManager.getRequestToken { result in
//            print("getRequestToken -> \(result.requestToken!)")
//            self.networkManager.validateWithLogin(login: username, password: password, requestToken: result.requestToken!) { result in
//                print("validateWithLogin -> \(result)")
//                self.networkManager.createSession(requestToken: result.requestToken!) { result in
//                    print("createSession -> \(result)")
//                }
//            }
//        }
