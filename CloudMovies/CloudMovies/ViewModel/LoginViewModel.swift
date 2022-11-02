//
//  LoginViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 29.10.2022.
//

import Foundation

class LoginViewModel {
    private(set) var sessionID: String = "" // KEY CHAIN
    private(set) var accountID: Int = 0 // FIND PLACE TO HOLD IT
    private(set) var guestSessionID: String = "" // KEY CHAIN?
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    func makeAuthentication(username: String, password: String, completion: @escaping((Bool) -> Void)) { // , sessionID: (_ sessionID: String) -> Void)
        networkManager.getRequestToken { result in
            guard let token = result.requestToken else { return }
            self.networkManager.validateWithLogin(login: username, password: password, requestToken: token) { result in
                self.networkManager.createSession(requestToken: result.requestToken ?? "") { success in
                    self.sessionID = success.sessionID ?? ""
                    print("\(self.sessionID) SESSION ID")
                    completion(success.success!)
                    //                    self.networkManager.getAccount(sessionID: success.sessionID!) { accountID in
                    //                        self.accountID = accountID.id!
                }
            }
        }
    }
    func getAccountID(sessionID: String) {
        networkManager.getAccount(sessionID: sessionID) { account in
            self.accountID = account.id!
            print("\(self.accountID) ACCOUNT ID")
        }
    }
    func getGuestSessionID() {
        networkManager.getGuestSessionID { session in
            self.guestSessionID = session.guestSessionId!
            print("\(self.guestSessionID) GUEST ID")
        }
    }
}
