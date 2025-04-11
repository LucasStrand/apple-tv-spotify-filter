import SwiftUI

@main
struct SpotifyFilterTVApp: App {
    @StateObject private var authManager = SpotifyAuthManager.shared
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .onOpenURL { url in
                    if url.scheme == "spotify-filter-tv" {
                        authManager.handleAuthCallback(url: url)
                    }
                }
        }
    }
} 