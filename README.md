# Fitness Tracker

Fitness Tracker is a cross-platform Flutter application that helps users stay on top of their health goals by combining real-time activity tracking, goal management, and reflective journaling. The app integrates tightly with Firebase for authentication and data storage while leveraging native sensors and GetX state management to deliver a responsive experience.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Firebase Configuration](#firebase-configuration)
- [Running the App](#running-the-app)
- [Testing](#testing)
- [Project Structure](#project-structure)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Overview

`fitness_tracker` empowers users to set and monitor daily fitness goals, track activity through their device pedometer, and log personal reflections. The home experience combines 3D visualizations, intuitive goal progress indicators, and quick actions, making it easy to stay motivated and accountable.

## Features

- **Firebase Authentication** – Secure email and password login with `firebase_auth` and session handling managed in `lib/controllers/login_controller.dart`.
- **Personalized Dashboard** – Adaptive home screen (`lib/screens/home_screen.dart`) with goal summaries, journal entries, and a profile view orchestrated via `HomeController` and GetX reactive state.
- **Daily Goals Management** – Calorie, step, sleep, water, and BMI goals managed by `DailyGoalsController`, persisted in Firestore, and visualized through custom widgets like `GoalProgressRing`.
- **Step Tracking** – Live pedometer integration (`StepCalculationController`) with permission handling and automatic baseline calibration.
- **Reflective Journaling** – Calendar-driven journal component (`lib/widgets/journal_widget.dart`) allowing users to add entries tied to specific dates.
- **Historical Insights** – Access to goal history (`lib/screens/history_screens.dart`) leveraging Firestore snapshots to surface progress trends.
- **3D Motivational Model** – Interactive `O3DViewer` widget providing a visual companion that adapts camera angles based on user context.

## Architecture

The app follows a modular structure built around GetX for dependency injection, routing, and reactive state.

- **Routing** – Centralized navigation declared in `lib/routes/app_routes.dart` with bindings that inject controllers per screen.
- **Controllers** – Business logic is organized in `lib/controllers/`, separating concerns such as authentication, profile management, daily goals, journaling, and pedometer tracking.
- **Services** – Firebase access is abstracted in `lib/firebase/service/fireservice.dart`, encapsulating reads/writes to Firestore collections.
- **Widgets** – Reusable UI components live in `lib/widgets/`, promoting composability and consistent styling.

## Tech Stack

- Flutter 3.x (Dart SDK ^3.8.0-265.0.dev)
- GetX for state management, navigation, and dependency injection
- Firebase Core, Authentication, and Cloud Firestore
- `pedometer` and `permission_handler` for step tracking
- `shared_preferences` for local persistence
- `o3d` for 3D model rendering
- `google_fonts`, `easy_date_timeline`, `simple_circular_progress_bar`, and other UI libraries

## Getting Started

### Prerequisites

1. Flutter SDK 3.8 (or newer) with compatible Dart SDK.
2. Android Studio or VS Code with Flutter/Dart extensions.
3. A configured Firebase project (Authentication + Firestore enabled).
4. An Android or iOS device/emulator with motion sensors for pedometer testing.

### Installation

```bash
git clone https://github.com/<your-org>/fitness_tracker.git
cd fitness_tracker
flutter pub get
```

### Firebase Configuration

1. Create a Firebase project and register your Android, iOS, and/or web apps.
2. Download platform-specific configuration files:
   - `google-services.json` (Android) → `android/app/`
   - `GoogleService-Info.plist` (iOS) → `ios/Runner/`
3. Run `flutterfire configure` or manually update `lib/firebase_options.dart` with your Firebase credentials.
4. Ensure Firestore security rules allow authenticated read/write for user-owned documents.

## Running the App

```bash
flutter run
```

For Android pedometer functionality, deploy to a physical device and grant the **ACTIVITY_RECOGNITION** permission when prompted.

## Testing

Unit/widget tests can be executed with:

```bash
flutter test
```

> Tip: Add targeted tests for controllers in `lib/controllers/` to validate calculation logic (e.g., BMI, water intake progress) as the codebase grows.

## Project Structure

```
lib/
├── bindings/                # GetX bindings for dependency injection per route
├── controllers/             # Business logic and reactive state
├── firebase/                # Firebase service layer
├── model/                   # Data models (e.g., DailyGoalModel)
├── routes/                  # Route definitions (AppRoutes)
├── screens/                 # Feature screens (Splash, Login, Home, History, etc.)
├── services/                # Background services and utilities
└── widgets/                 # Reusable presentation components
```

## Troubleshooting

- **Firebase Initialization Errors**: Confirm `DefaultFirebaseOptions.currentPlatform` contains your project credentials and that configuration files are present.
- **Permission Denied (Firestore)**: Update Firestore rules or verify authenticated user IDs align with document paths in `FirestoreService`.
- **Pedometer Returns 0 Steps**: Test on a physical device with motion sensors and ensure the ACTIVITY_RECOGNITION permission is granted.
- **3D Viewer Not Rendering**: Check that assets in `assets/3d_model/` are bundled and the device supports WebGL/OpenGL ES.

## Contributing

1. Fork the repository and create a feature branch.
2. Follow the existing code style enforced by `analysis_options.yaml`.
3. Submit a pull request with a clear description and screenshots or screen recordings when applicable.

## License

This project is currently distributed for internal use. Contact the maintainers for licensing inquiries.
