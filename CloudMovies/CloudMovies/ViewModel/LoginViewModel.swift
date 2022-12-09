//
//  LoginViewModel.swift
//  CloudMovies
//
//  Created by Артем Билый on 29.10.2022.
//

import Foundation
import KeychainAccess

final class LoginViewModel {
    // MARK: - Network
    private lazy var networkManager: NetworkService = {
        return NetworkService()
    }()
    weak var delegate: ViewModelProtocol?
    // MARK: Guest ID
    func getGuestSessionID() {
        networkManager.getGuestSessionID { session in
            if let session = session.guestSessionID {
                do {
                    try StorageSecure.keychain.set(session, key: "guestID")
                } catch {
                    print("Unavailable set guest ID")
                }
            }
        }
        StorageSecure.keychain["sessionID"] = nil
        StorageSecure.keychain["accountID"] = nil
    }
    // MARK: Authentification 3 steps
    func makeAuthentication(username: String, password: String, completion: @escaping ((Bool) -> Void)) {
        networkManager.getRequestToken { result in
            guard let token = result.requestToken else { return }
            self.networkManager.validateWithLogin(login: username, password: password, requestToken: token) { result in
                self.networkManager.createSession(requestToken: result.requestToken ?? "") { success in
                    if let id = success.sessionID {
                        do {
                            try StorageSecure.keychain.set(id, key: "sessionID")
                        } catch {
                            print("Unavailable set session ID")
                        }
                    }
                    if let success = success.success {
                        completion(success)
                    }
                }
            }
        }
    }
    // MARK: Account ID
    func getAccountID(_ sessionID: String) {
        networkManager.getAccount(sessionID: sessionID) { account in
            if let id = account.id {
                do {
                    try StorageSecure.keychain.set(String(id), key: "accountID")
                } catch {
                    print("Unavailable set accound ID")
                }
            }
        }
    }
}
