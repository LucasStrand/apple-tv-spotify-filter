# Spotify Filter TV

An Apple TV application that enhances Spotify playlist management with advanced filtering capabilities.

## Prerequisites

1. **Hardware Requirements**
   - Mac computer (required for Xcode and tvOS development)
   - Apple TV device or Apple TV simulator
   - Apple Developer Account ($99/year)

2. **Software Requirements**
   - Xcode 14.0 or later
   - tvOS 16.0 or later
   - Spotify Developer Account (free)

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/LucasStrand/apple-tv-spotify-filter.git
   cd apple-tv-spotify-filter
   ```

2. **Configure Spotify API**
   - Go to [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
   - Create a new application
   - Get your Client ID and Client Secret
   - Add the redirect URI: `spotify-filter-tv://callback`
   - Update `Config.swift` with your credentials:
     ```swift
     static let spotifyClientID = "YOUR_CLIENT_ID"
     static let spotifyClientSecret = "YOUR_CLIENT_SECRET"
     ```

3. **Configure Xcode Project**
   - Open `SpotifyFilterTV.xcodeproj` in Xcode
   - Select the project in the navigator
   - Go to the "Signing & Capabilities" tab
   - Select your development team
   - Set the bundle identifier to something unique (e.g., `com.yourdomain.spotifyfiltertv`)

4. **Configure URL Scheme**
   - In Xcode, select your project
   - Go to the "Info" tab
   - Under "URL Types", add a new URL type
   - Set the URL Scheme to "spotify-filter-tv"
   - Set the Role to "Editor"

## Running the Application

1. **Build and Run**
   - Select "Apple TV" as the target device (either physical device or simulator)
   - Click the "Run" button (⌘R) or select Product > Run from the menu

2. **Testing Authentication**
   - The app will launch with a login screen
   - Click the "Login with Spotify" button
   - You'll be redirected to Spotify's login page
   - After successful login, you'll be redirected back to the app

3. **Using the App**
   - Once logged in, you'll see your Spotify profile
   - Navigate through your playlists
   - Use the filtering features to sort and filter your playlists

## Development Notes

- The app uses SwiftUI for the user interface
- Authentication is handled through Spotify's OAuth2 flow
- Playlist data is fetched using Spotify's Web API
- The app is optimized for tvOS navigation using the Apple TV remote

## Troubleshooting

1. **Authentication Issues**
   - Ensure your redirect URI matches exactly in both the app and Spotify Dashboard
   - Check that your Client ID and Secret are correct
   - Verify your Spotify account has the necessary permissions

2. **Build Issues**
   - Make sure you're using the correct version of Xcode
   - Verify your Apple Developer account is properly set up
   - Check that your provisioning profiles are correctly configured

3. **Runtime Issues**
   - Ensure you have an active internet connection
   - Verify your Spotify account is active and premium (if required)
   - Check that your Apple TV is running a compatible version of tvOS

## Contributing

Feel free to submit issues and enhancement requests! Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Project Structure

- `SpotifyFilterTV/`