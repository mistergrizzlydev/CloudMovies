//
//  LoginViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 29.10.2022.
//

import Foundation

class LoginViewModel {
    private(set) var sessionID: String = UserDefaults.standard.string(forKey: "sessionID") ?? "" { // KEY CHAIN IN FUTURE
        didSet {
            UserDefaults.standard.set(sessionID, forKey: "sessionID")
            UserDefaults.standard.synchronize()
        }
    }
    private(set) var accountID: Int = UserDefaults.standard.integer(forKey: "accountID") {
        didSet {
            UserDefaults.standard.set(accountID, forKey: "accountID")
            UserDefaults.standard.synchronize()
        }
    }
    private(set) var guestSessionID: String = UserDefaults.standard.string(forKey: "guestSessionID") ?? "" { // KEY CHAIN IN FUTURE
        didSet {
            UserDefaults.standard.set(guestSessionID, forKey: "guestSessionID")
            UserDefaults.standard.synchronize()
        }
    }
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    weak var delegate: ViewModelProtocol?
    func makeAuthentication(username: String, password: String, completion: @escaping((Bool) -> Void)) {
        networkManager.getRequestToken { result in
            guard let token = result.requestToken else { return }
            self.networkManager.validateWithLogin(login: username, password: password, requestToken: token) { result in
                self.networkManager.createSession(requestToken: result.requestToken ?? "") { success in
                    self.sessionID = success.sessionID ?? ""
                    print(self.sessionID)
                    completion(success.success!)
                }
            }
        }
    }
    func getAccountID(sessionID: String) {
        networkManager.getAccount(sessionID: sessionID) { account in
            self.accountID = account.id!
        }
    }
    func getGuestSessionID() {
        networkManager.getGuestSessionID { session in
//            self.guestSessionID = session.guestSessionId!
            KeySecure.shared["sessionID"] = session.guestSessionId!
            let keychain = KeySecure()
            print(keychain.sessionID)
        }
    }
}
