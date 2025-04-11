# Spotify Filter TV

An Apple TV application that enhances Spotify playlist management with advanced filtering capabilities.

## Setup Instructions

1. **Prerequisites**
   - Xcode 14.0 or later
   - tvOS 16.0 or later
   - Spotify Developer Account
   - Apple Developer Account

2. **Configuration**
   - Add your Spotify Client ID and Client Secret to `Config.swift`
   - Set up proper URL scheme in Info.plist
   - Configure redirect URI in Spotify Developer Dashboard

3. **Features**
   - Spotify authentication
   - Playlist browsing
   - Advanced filtering capabilities
   - TV-optimized interface

## Project Structure

- `SpotifyFilterTV/` - Main app target
- `SpotifyFilterTVTests/` - Unit tests
- `SpotifyFilterTVUITests/` - UI tests

## Dependencies

- Spotify iOS SDK
- SwiftUI
- Combine 