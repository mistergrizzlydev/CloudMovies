//
//  LoginViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 29.10.2022.
//

import Foundation

final class LoginViewModel {
    // MARK: Network
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    weak var delegate: ViewModelProtocol?
    // KEY CHAIN IN FUTURE
    private(set) var sessionID: String = UserDefaults.standard.string(forKey: "sessionID") ?? "" {
        didSet {
            UserDefaults.standard.setValue(sessionID, forKey: "sessionID")
            UserDefaults.standard.synchronize()
        }
    }
    private(set) var accountID: Int = UserDefaults.standard.integer(forKey: "accountID") {
        didSet {
            UserDefaults.standard.setValue(accountID, forKey: "accountID")
            UserDefaults.standard.synchronize()
        }
    }
    private(set) var guestSessionID: String = UserDefaults.standard.string(forKey: "guestSessionID") ?? "" {
        didSet {
            UserDefaults.standard.setValue(guestSessionID, forKey: "guestSessionID")
            UserDefaults.standard.synchronize()
        }
    }
    // MARK: Guest ID
    func getGuestSessionID() {
        networkManager.getGuestSessionID { session in
            if let sesion = session.guestSessionId {
                self.guestSessionID = sesion
                self.sessionID = ""
            }
        }
    }
    // MARK: Authentification 3 steps
    func makeAuthentication(username: String, password: String, completion: @escaping((Bool) -> Void)) {
        networkManager.getRequestToken { result in
            guard let token = result.requestToken else { return }
            self.networkManager.validateWithLogin(login: username, password: password, requestToken: token) { result in
                self.networkManager.createSession(requestToken: result.requestToken ?? "") { success in
                    if let id = success.sessionID {
                        self.sessionID = id
                        self.guestSessionID = ""
                    }
                    if let success = success.success {
                        completion(success)
                    }
                }
            }
        }
    }
    // MARK: Account ID
    func getAccountID(sessionID: String) {
        networkManager.getAccount(sessionID: sessionID) { account in
            if let id = account.id {
                self.accountID = id
            }
        }
    }
}
