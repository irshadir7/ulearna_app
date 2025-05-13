# 📱 Ulearna Reels Flutter App

A Flutter application mimicking the reels interface to fetch and display video content from an API with features like lazy loading, pagination, and caching.

---

## 🧰 Tech Stack & Dependencies

- **Flutter SDK**
- **BLoC** – State management (`flutter_bloc: ^9.1.1`)
- **HTTP** – API requests (`http: ^1.4.0`)
- **Video Player** – Video playback (`video_player: ^2.9.5`)
- **Better Player Plus** – Advanced video options (`better_player_plus: ^1.0.8`)
- **Dependency Injection** – Using `get_it: ^8.0.3`
- **Data Caching** – `shared_preferences: ^2.5.3`
- **Equatable** – For comparing BLoC states (`equatable: ^2.0.7`)
- **Cached Network Image** – Image caching (`cached_network_image: ^3.4.1`)
- **Logger** – Logging and debugging (`logger: ^2.5.0`)
- **Internet Checker** – Network connectivity check (`internet_connection_checker: ^3.0.1`)
- **Font Awesome Flutter** – Icons (`font_awesome_flutter: ^10.8.0`)

---

## 📦 Installation Guide

### ✅ Prerequisites

- Flutter SDK installed
- Android Studio / Xcode / VSCode
- Device or emulator ready

---

### 🚀 Run the App

1. **Clone the repository:**
   ```bash
   git clone https://github.com/irshadir7/ulearna_app.git
   cd ulearna_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

### 📱 Platform-Specific Steps

#### 📲 Android
Run in debug mode:
```bash
flutter run
```

#### 🍏 iOS
Open in Xcode:
```bash
cd ios
open Runner.xcworkspace
```
Then build and run through Xcode.

---

## 🔧 Troubleshooting

If you encounter any issues:
- Ensure Flutter SDK is up to date: `flutter upgrade`
- Reset cache if needed: `flutter clean`
- Verify dependencies: `flutter doctor`

---