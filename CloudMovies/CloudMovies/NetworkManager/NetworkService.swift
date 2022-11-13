//
//  NetworkService.swift
//  CloudMovies
//
//  Created by Артем Билый on 25.10.2022.
//

import Foundation

class NetworkService {
    //apiKey
    private let apiKey: String = "b3187cf196a7681dee8805cdcec0d6ba"
    //MARK: - genres movie
    func getGenresMovie(completion: @escaping(([GenresModel.Genre]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/genre/\(MediaType.movie.rawValue)/list?api_key=\(apiKey)&language=en-US") else {
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
    //MARK: - genres TVShow
    func getGenresTVShows(completion: @escaping(([GenresModel.Genre]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/genre/\(MediaType.tvShow.rawValue)/list?api_key=\(apiKey)&language=en-US") else {
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
    //MARK: - popular movies
    func getPopularMovies(completion: @escaping(([MediaModel.Media]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.popular.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
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
    //MARK: - toprated movies
    func getTopRatedMovies(completion: @escaping(([MediaModel.Media]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.topRated.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
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
    //MARK: - nowplaying movies
    func getNowPlayingMovies(completion: @escaping(([MediaModel.Media]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.nowPlaying.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MediaModel.MediaResponse.self, from: data)
                guard let response = response.results else { return }
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    //MARK: - upcoming movies
    func getUpcomingMovies(completion: @escaping(([MediaModel.Media]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(MediaSection.upcoming.rawValue)?api_key=\(apiKey)&language=en-US&page=1") else {
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
                    DispatchQueue.main.async {
                        completion(response)
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
// MARK: - TVShows
    // MARK: popular TVShows
    func getPopularTVShows(completion: @escaping(([MediaModel.Media]) -> Void)) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return}
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MediaModel.MediaResponse.self, from: data)
                DispatchQueue.main.async {
                    guard let result = response.results else { return }
                    completion(result)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    //MARK: top rated TVShows
    func getTopRatedTVShows(completion: @escaping(([MediaModel.Media]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/tv/top_rated?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return}
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MediaModel.MediaResponse.self, from: data)
                DispatchQueue.main.async {
                    guard let result = response.results else { return }
                    completion(result)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    //MARK: on the air TVShows
    func getThisWeek(completion: @escaping(([MediaModel.Media]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/tv/on_the_air?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return}
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MediaModel.MediaResponse.self, from: data)
                DispatchQueue.main.async {
                    guard let result = response.results else { return }
                    completion(result)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    //MARK: airing today(new episodes)
    func getNewEpisodes(completion: @escaping(([MediaModel.Media]) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/tv/airing_today?api_key=\(apiKey)&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return}
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MediaModel.MediaResponse.self, from: data)
                DispatchQueue.main.async {
                    guard let result = response.results else { return }
                    completion(result)
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
//MARK: - sorted movies
    func sortedMovies(completion: @escaping(([String: [MediaModel.Media]]) -> ())) {
        getGenresMovie { response in
            var dict: [String: [MediaModel.Media]] = [:]
            for genre in response {
                guard let genreId = genre.id else { return }
                guard let apiURL = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(self.apiKey)&language=en-US&sort_by=popularity.desc&include_video=false&page=1&with_genres=\(genreId)") else {
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
//MARK: - sorted TVShows
    func sortedTVShows(completion: @escaping(([String: [MediaModel.Media]]) -> ())) {
        getGenresTVShows { response in
            var dict: [String: [MediaModel.Media]] = [:]
            for genre in response {
                guard let apiURL = URL(string: "https://api.themoviedb.org/3/discover/tv?api_key=\(self.apiKey)&sort_by=popularity.desc&with_genres=\(genre.id!)") else {
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
    //MARK: - search request
    func getSearchedMedia(query: String, page: Int, mediaType: String, completion: @escaping ((MediaModel.MediaResponse) -> ())) {
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
    //MARK: - single movie details
    func getMovieDetails(movieId: Int, completion: @escaping ((MovieDetailsModel.MovieResponse) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieDetailsModel.MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    func getTVShowDetails(tvShowId: Int, completion: @escaping ((TVShowsDetailModel.TVShowResponse) -> ())) {
        guard let apiURL = URL(string: "https://api.themoviedb.org/3/tv/\(tvShowId)?api_key=\(apiKey)&language=en-US") else {
            fatalError("Invalid URL")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TVShowsDetailModel.TVShowResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    //MARK: - Videos Request
    func getVideos(mediaID: Int, mediaType: String, completion: @escaping (([YoutubeModel.Video]) -> ())) {
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
    //MARK: - Requst Token
    func getRequestToken(completion: @escaping ((TokenResponse) -> ())) {
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
    
    func validateWithLogin(login: String, password: String, requestToken: String, completion: @escaping((TokenResponse) -> ())) {
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
    func createSession(requestToken: String, completion: @escaping((SessionResponse)) -> ()) {
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
//MARK: - Watchlist
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
    //mediaType for tv???
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
}
