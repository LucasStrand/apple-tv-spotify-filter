import Foundation

enum Config {
    // Replace these with your actual Spotify credentials
    static let spotifyClientID = "YOUR_CLIENT_ID"
    static let spotifyClientSecret = "YOUR_CLIENT_SECRET"
    
    // URL Scheme for Spotify authentication
    static let redirectURI = "spotify-filter-tv://callback"
    
    // Spotify API endpoints
    static let spotifyAuthURL = "https://accounts.spotify.com/authorize"
    static let spotifyTokenURL = "https://accounts.spotify.com/api/token"
    static let spotifyAPIBaseURL = "https://api.spotify.com/v1"
    
    // Scopes required for the app
    static let spotifyScopes = [
        "user-read-private",
        "playlist-read-private",
        "playlist-read-collaborative",
        "user-library-read",
        "user-read-playback-state",
        "user-modify-playback-state"
    ].joined(separator: " ")
} 