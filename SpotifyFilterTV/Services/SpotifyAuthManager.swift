import Foundation
import Combine

class SpotifyAuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: SpotifyUser?
    
    private var authToken: String?
    private var refreshToken: String?
    
    static let shared = SpotifyAuthManager()
    
    private init() {}
    
    func startAuthFlow() -> URL? {
        var components = URLComponents(string: Config.spotifyAuthURL)!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: Config.spotifyClientID),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "redirect_uri", value: Config.redirectURI),
            URLQueryItem(name: "scope", value: Config.spotifyScopes),
            URLQueryItem(name: "show_dialog", value: "true")
        ]
        return components.url
    }
    
    func handleAuthCallback(url: URL) {
        guard let code = URLComponents(url: url, resolvingAgainstBaseURL: true)?
            .queryItems?
            .first(where: { $0.name == "code" })?
            .value else {
            print("No code found in callback URL")
            return
        }
        
        exchangeCodeForToken(code: code)
    }
    
    private func exchangeCodeForToken(code: String) {
        var request = URLRequest(url: URL(string: Config.spotifyTokenURL)!)
        request.httpMethod = "POST"
        
        let parameters = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": Config.redirectURI,
            "client_id": Config.spotifyClientID,
            "client_secret": Config.spotifyClientSecret
        ]
        
        request.httpBody = parameters
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error exchanging code for token: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(SpotifyAuthResponse.self, from: data)
                self?.authToken = response.access_token
                self?.refreshToken = response.refresh_token
                self?.isAuthenticated = true
                self?.fetchUserProfile()
            } catch {
                print("Error decoding auth response: \(error)")
            }
        }.resume()
    }
    
    private func fetchUserProfile() {
        guard let token = authToken else { return }
        
        var request = URLRequest(url: URL(string: "\(Config.spotifyAPIBaseURL)/me")!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching user profile: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let user = try JSONDecoder().decode(SpotifyUser.self, from: data)
                DispatchQueue.main.async {
                    self?.currentUser = user
                }
            } catch {
                print("Error decoding user profile: \(error)")
            }
        }.resume()
    }
}

struct SpotifyAuthResponse: Codable {
    let access_token: String
    let token_type: String
    let scope: String
    let expires_in: Int
    let refresh_token: String
}

struct SpotifyUser: Codable {
    let id: String
    let display_name: String?
    let email: String?
    let images: [SpotifyImage]?
}

struct SpotifyImage: Codable {
    let url: String
    let height: Int?
    let width: Int?
} 