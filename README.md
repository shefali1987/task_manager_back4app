# Task Manager App (Flutter)

This is a simple mobile application built with **Flutter** that allows users to manage their daily tasks. It uses **Back4App** as the backend for user authentication and cloud-based task storage.

## Project Overview

The Task Manager App allows users to:

- Sign up and log in securely.
- Add tasks with a title and description.
- View all tasks on the dashboard.
- Edit and update existing tasks.
- Mark tasks as completed using a toggle switch.
- Delete tasks.
- Log out securely with Back4App session handling.

## Technologies Used

- **Flutter** – Cross-platform framework for Android and iOS.
- **Parse SDK for Flutter** – To interact with Back4App for authentication and CRUD operations.
- **Back4App** – Backend as a Service (BaaS) providing database, authentication, and cloud storage.

## Features

### User Authentication
Secure signup and login functionality managed by Back4App.

### Task Management
- Add new tasks (title + description).
- View all tasks in the dashboard.
- Edit task details.
- Mark tasks as completed (updates `isDone` in Back4App).
- Delete tasks.

### Data Persistence
All task data is stored in Back4App, making it available across sessions.

## Architecture

**Frontend (Flutter):** UI, navigation, user interaction.  
**Backend (Back4App):** Authentication, database, cloud APIs.  
**Parse SDK:** Connects Flutter with Back4App.

## Setup Instructions

### Prerequisites
- Flutter SDK installed
- Android Studio / VS Code
- Back4App account with a Parse App

### Clone the Repository
```
git clone <your_repository_url>
cd task_manager_back4app
```

### Install Dependencies
```
flutter pub get
```

### Configure Back4App
Replace your credentials in `main.dart`:
```
const keyApplicationId = "<YOUR_APP_ID>";
const keyClientKey = "<YOUR_CLIENT_KEY>";
const keyParseServerUrl = "https://parseapi.back4app.com";
```

Initialize Parse:
```
await Parse().initialize(
  keyApplicationId,
  keyParseServerUrl,
  clientKey: keyClientKey,
  autoSendSessionId: true,
);
```

### Run the App
```
flutter run
```

## Code Structure
```
lib/
 ├── main.dart
 ├── login_screen.dart
 ├── signup_screen.dart
 ├── home_screen.dart
 ├── services/
 │     └── back4app_service.dart
 └── widgets/
       └── task_tile.dart
```
