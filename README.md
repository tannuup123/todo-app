# 📝 TaskMaster: Clean Architecture ToDo Application

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/BLoC-State_Management-blueviolet?style=for-the-badge)
![Hive](https://img.shields.io/badge/Hive-Offline_Storage-orange?style=for-the-badge)

## 🚀 Objective
A production-ready, offline-first ToDo application built to demonstrate clean architecture principles, efficient state management, and robust local storage.

## ✨ Functional Features
* **Task Management**: Add, edit, delete, and mark tasks as completed.
* **Task Details**: Complete support for task titles, descriptions, priority levels, and due dates.
* **Search & Filter**: Find tasks quickly using keywords and filter them by status or priority.
* **Local Notifications**: Scheduled reminders using `flutter_local_notifications` so deadlines are never missed.
* **Offline-First**: Blazing fast and reliable offline storage using Hive.

## 🌟 Bonus Features Implemented
* 🌓 **Dark Mode**: Seamless system-aware and manual theme toggling.
* 🔄 **Recurring Tasks**: Architecture support for tasks that repeat on a schedule.

## 🏗️ Technical Architecture
This project is strictly organized using **Clean Architecture** to ensure separation of concerns, scalability, and high testability:

1.  **Domain Layer**: Contains the core business logic, Entities, and Use Cases. Completely independent of the Flutter framework.
2.  **Data Layer**: Implements the repositories defined in the domain layer and handles all local storage operations with Hive.
3.  **Presentation Layer**: Manages the UI and state using **BLoC**, reacting to state changes and triggering use cases.

**Core Tech Stack**:
* State Management: `flutter_bloc`
* Dependency Injection: `get_it`
* Storage: `hive`, `hive_flutter`
* Notifications: `flutter_local_notifications`

## ⚡ Performance & Optimization
* **APK Size Reduction**: Assets, fonts, and dependencies are strictly managed to keep the final production build footprint minimal.
* **Efficient UI Rendering**: Leveraged `const` constructors and localized BLoC states (using `BlocBuilder` and `BlocSelector`) to ensure a flawless 60 FPS experience without unnecessary widget rebuilds.

## 🚀 Setup Instructions

1.  Clone the repository:
    ```bash
    git clone https://github.com/tannuup123/todo-app.git
    ```
2.  Navigate to the project directory:
    ```bash
    cd todo-app
    ```
3.  Install dependencies:
    ```bash
    flutter pub get
    ```
4.  Run code generation (required for Hive adapters and GetIt injection):
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
5.  Run the application:
    ```bash
    flutter run
    ```

