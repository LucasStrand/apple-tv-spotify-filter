import SwiftUI

struct LoginView: View {
    @StateObject private var authManager = SpotifyAuthManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "music.note.tv")
                .font(.system(size: 100))
                .foregroundColor(.green)
            
            Text("Spotify Filter TV")
                .font(.largeTitle)
                .bold()
            
            Text("Enhanced playlist filtering for your Apple TV")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if !authManager.isAuthenticated {
                Button(action: {
                    if let url = authManager.startAuthFlow() {
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "music.note")
                        Text("Login with Spotify")
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                if let user = authManager.currentUser {
                    VStack {
                        Text("Welcome, \(user.display_name ?? "User")!")
                            .font(.headline)
                        
                        if let imageUrl = user.images?.first?.url,
                           let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                        }
                    }
                }
            }
        }
        .padding()
    }
} 