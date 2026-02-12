# Productivity App
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/ayanegm/productivity_app)

A comprehensive productivity and task management application built with Flutter and Firebase. This app helps users organize their daily tasks, track their progress, and maintain focus with an integrated timer.

## Core Features

*   **Task Management**: Create, view, and manage tasks with titles, detailed descriptions, categories, and estimated durations.
*   **Calendar Integration**: View and organize your tasks on a full-screen calendar to easily manage your schedule.
*   **Focus Timer**: Start a timer for any task to stay focused. The app automatically marks tasks as complete when the timer finishes.
*   **Progress Analytics**: A dashboard provides insights into your productivity, displaying total, ongoing, and completed tasks.
*   **Category-Based Tracking**: Organize tasks into categories like 'Work', 'Design', 'Fitness', and 'Meeting'. The home screen shows task counts for each active category.
*   **User Authentication**: Secure sign-up and login functionality using Firebase Authentication (Email & Password).
*   **Reminders & Notifications**: Set reminders for your tasks and receive in-app alerts to stay on track.

## Technology Stack

*   **Framework**: Flutter
*   **Backend**: Firebase
    *   **Database**: Cloud Firestore for real-time data storage.
    *   **Authentication**: Firebase Auth for user management.
    *   **Notifications**: Firebase Cloud Messaging (FCM) for push notifications.
*   **State Management**: Provider
*   **Key Packages**:
    *   `table_calendar`: For the calendar UI.
    *   `fl_chart`: For displaying progress charts.
    *   `flutter_slidable`: For interactive task actions.
    *   `provider`: For state management.
    *   `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_messaging`

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK installed on your machine.
*   A code editor like VS Code or Android Studio.
*   A Firebase project.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/ayanegm/productivity_app.git
    cd productivity_app
    ```

2.  **Set up Firebase:**
    *   Create a new project on the [Firebase Console](https://console.firebase.google.com/).
    *   Follow the instructions to add an Android, iOS, and Web app to your project.
    *   Download the `google-services.json` file and place it in the `android/app/` directory.
    *   For web and other platforms, configure your project with the FlutterFire CLI by running:
        ```sh
        flutterfire configure
        ```
    *   This will generate a `lib/firebase_options.dart` file with your project's specific credentials.

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the application:**
    ```sh
    flutter run
    ```

## Project Structure

The project code is organized within the `lib` directory, following a feature-driven structure:

*   `lib/`
    *   `main.dart`: The entry point of the application.
    *   `models/`: Contains the data models for the application (e.g., `TaskModel`, `UserModel`, `TaskAnalyticsModel`).
    *   `screens/`: Includes all the UI pages of the app, such as the login screen, home page, and task creation page.
    *   `widgets/`: Houses reusable UI components (e.g., custom buttons, task containers, navigation bar).
    *   `services/`: Encapsulates business logic and communication with backend services like Firebase (`TaskService`).
    *   `providers/`: Manages the application's state using the Provider package (`TaskProvider`).
    *   `helper/`: Contains utility functions and helper classes for tasks like handling notifications and styling categories.
