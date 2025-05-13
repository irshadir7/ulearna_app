
This Flutter application fetches and displays video reels from a remote API with clean architecture, pagination, caching, and BLoC-based state management.

---

## 🚀 Features

- 🔁 Infinite scroll (pagination)
- ⬇️ Lazy loading with video caching
- 🎥 Reels-style full-screen video player
- 📦 Clean architecture (Presentation, Domain, Data layers)
- 🧠 BLoC for state management
- 🔌 Dependency injection using `get_it`
- 🧠 Offline support with `shared_preferences`
- ✅ Robust error handling

---

## 🧱 Architecture Overview

```txt
lib/
├── core/                 # Shared helpers & error classes
├── data/                 # API services, models, repositories
├── domain/               # Entities & use cases
├── presentation/         # UI widgets, BLoCs
│   ├── blocs/
│   ├── pages/
│   └── widgets/
├── di/                   # Dependency injection
└── main.dart             # App entry point

📲 Getting Started
✅ Prerequisites
Flutter SDK (>=3.10.0)

Xcode (for iOS)

Android Studio or VS Code

Emulator or real device