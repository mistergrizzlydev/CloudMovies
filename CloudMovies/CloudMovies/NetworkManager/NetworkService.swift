//
//  NetworkService.swift
//  CloudMovies
//
//  Created by Артем Билый on 25.10.2022.
//

import Foundation

final class NetworkService {
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"
    // MARK: - genres
    func getGenres(mediaType: String, completion: @escaping(([GenresModel.Genre]) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/genre/\(mediaType)/list?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GenresModel.GenresResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.genres!)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    // MARK: - get media list
    func getMediaList(mediaType: String, sorted: String, completion: @escaping(([MediaModel.Media]) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/\(mediaType)/\(sorted)?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MediaModel.MediaResponse.self, from: data)
                DispatchQueue.main.async {
                    guard let response = response.results else { return }
                    completion(response)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    // MARK: - sorted movies
    func sortedMediaList(mediaType: String, completion: @escaping(([String: [MediaModel.Media]]) -> Void)) {
        getGenres(mediaType: mediaType) { response in
            var dict: [String: [MediaModel.Media]] = [:]
            for genre in response {
                guard let genreId = genre.id else { return }
                guard let apiURL = URL(string: "https://api.themoviedb.org/3/discover/\(mediaType)?api_key=\(self.apiKey)&sort_by=popularity.desc&with_genres=\(genreId)") else {
                    fatalError("Invalid URL")
                }
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: apiURL) { data, response, error in
                    guard let data = data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(MediaModel.MediaResponse.self, from: data)
                        DispatchQueue.main.async {
                            dict[genre.name!] = response.results
                            completion(dict)
                        }
                    } catch {
                        print("Error: \(error)")
                    }
                }
                task.resume()
            }
        }
    }
    // MARK: - search request
    func getSearchedMedia(query: String, page: Int, mediaType: String, completion: @escaping ((MediaModel.MediaResponse) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/search/\(mediaType)?api_key=\(apiKey)&query=\(query)&page=\(page)") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MediaModel.MediaResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    // MARK: - single movie details
    func getMovieDetails(movieId: Int, completion: @escaping ((MediaModel.Media) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MediaModel.Media.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    func getTVShowDetails(tvShowId: Int, completion: @escaping ((MediaModel.Media) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/tv/\(tvShowId)?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MediaModel.Media.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    // MARK: - Videos Request
    func getVideos(mediaID: Int, mediaType: String, completion: @escaping (([YoutubeModel.Video]) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/\(mediaType)/\(mediaID)/videos?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(YoutubeModel.VideoResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.results)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    // MARK: - Requst Token
    func getRequestToken(completion: @escaping ((TokenResponse) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=\(apiKey)") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TokenResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    func validateWithLogin(login: String, password: String, requestToken: String, completion: @escaping((TokenResponse) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=\(apiKey)") else {
            fatalError("Invalid URL")
        }
        let params: [String: Any] = [
            "username": login,
            "password": password,
            "request_token": requestToken
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        var request = URLRequest(url: apiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TokenResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    func createSession(requestToken: String, completion: @escaping((SessionResponse)) -> Void) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/authentication/session/new?api_key=\(apiKey)") else {
            fatalError("Invalid URL")
        }
        let params: [String: Any] = [
            "request_token": requestToken
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SessionResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    func getAccount(sessionID: String, completion: @escaping((AccountModel.Account) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/account?api_key=\(apiKey)&session_id=\(sessionID)") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(AccountModel.Account.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    func getGuestSessionID(completion: @escaping((GuestModel) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/authentication/guest_session/new?api_key=\(apiKey)") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(GuestModel.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    // MARK: - Watchlist
    func getWatchListMedia(accountID: Int, sessionID: String, mediaType: String, completion: @escaping(([MediaModel.Media]) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/account/\(accountID)/watchlist/\(mediaType)?api_key=\(apiKey)&language=en-US&session_id=\(sessionID)&sort_by=created_at.asc&page=1") else {
            fatalError("Invalid URL")
        }
        print(apiURL)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MediaModel.MediaResponse.self, from: data)
                DispatchQueue.main.async {
                    guard let results = response.results else { return }
                    completion(results)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    // mediaType for tv???
    func actionWatchList(mediaType: String = "movie", mediaID: String, bool: Bool = true, accountID: String, sessionID: String) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/account/\(accountID)/watchlist?api_key=\(apiKey)&session_id=\(sessionID)") else {
            fatalError("Invalid URL")
        }
        let params: [String: Any] = [
            "media_type": mediaType,
            "media_id": mediaID,
            "watchlist": bool
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TokenResponse.self, from: data)
                DispatchQueue.main.async {
                    print(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    func deleteSession(sessionID: String) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/authentication/session?api_key=\(apiKey)") else {
            fatalError("Invalid URL")
        }
        let params: [String: Any] = [
            "session_id": sessionID
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        var request = URLRequest(url: apiURL)
        request.httpMethod = "DELETE"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TokenResponse.self, from: data)
                DispatchQueue.main.async {
                    print(response)
                    UserDefaults.standard.setValue("", forKey: "sessionID")
                    UserDefaults.standard.synchronize()
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    func rateMedia(mediaType: String, mediaID: String, sessionID: String = "", guestID: String = "", value: Double) {
        var apiURL = URL(string: "")
        if sessionID != "" {
            apiURL = URL(string: "https://api.themoviedb.org/3/\(mediaType)/\(mediaID)/rating?api_key=\(apiKey)&session_id=\(sessionID)")
        } else {
            apiURL = URL(string: "https://api.themoviedb.org/3/\(mediaType)/\(mediaID)/rating?api_key=\(apiKey)&guest_session_id=\(guestID)")
        }
        let params: [String: Any] = [
            "value": value
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        var request = URLRequest(url: apiURL!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TokenResponse.self, from: data)
                DispatchQueue.main.async {
                    print(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
}
