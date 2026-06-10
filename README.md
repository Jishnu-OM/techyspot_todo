# TechySpot Todo App

## Overview

TechySpot Todo is a Flutter-based task management application that allows users to manage their daily tasks efficiently. The application follows Clean Architecture principles, uses Riverpod for state management, GoRouter for navigation, and Supabase as the backend service for authentication and task management.

---

# Project Setup Instructions

## Clone the Repository

```bash
git clone <repository-url>
cd techyspot_todo
```

## Install Dependencies

```bash
flutter pub get
```

## Environment Configuration

Create a `.env` file in the root directory:

```env
SUPABASE_URL=YOUR_SUPABASE_PROJECT_URL
SUPABASE_PUBLISHABLE_KEY=YOUR_SUPABASE_PUBLISHABLE_KEY
```

## Run the Application

```bash
flutter run
```

---

# Architecture Explanation

The project follows **Clean Architecture** to maintain separation of concerns and improve scalability and maintainability.

## Folder Structure

```text
lib/
│
├── core/
│   ├── constants/
│   ├── helpers/
│   ├── router/
│   ├── themes/
│   └── widgets/
│
├── features/
│   ├── authentication/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── home/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart
```

---

## Data Layer

Responsible for:

* API communication
* Supabase integration
* Models
* Repository implementations

Examples:

```text
AuthRemoteDatasource
HomeRemoteDatasource
AuthRepositoryImpl
HomeRepositoryImpl
```

---

## Domain Layer

Contains business logic and application rules.

Includes:

* Entities
* Repository Contracts
* Use Cases

Examples:

```text
TaskEntity
CreateTaskUseCase
UpdateTaskUseCase
DeleteTaskUseCase
GetTasksUseCase
LoginUseCase
LogoutUseCase
GoogleSignInUseCase
```

---

## Presentation Layer

Responsible for UI and state management.

Includes:

```text
Screens
Widgets
Providers
States
```

Examples:

```text
LoginScreen
HomeScreen
AuthNotifier
HomeNotifier
AuthState
HomeState
```

---

# State Management Approach

The application uses **Riverpod StateNotifier** for state management.

## Why Riverpod?

* Separation of UI and Business Logic
* Predictable state updates
* Testability
* Scalability
* Dependency Injection support

---

## Example Flow

```text
UI
 ↓
Provider (Notifier)
 ↓
Use Case
 ↓
Repository
 ↓
Datasource
 ↓
Supabase
```

### Authentication Flow

```text
Login Button
 ↓
AuthNotifier
 ↓
LoginUseCase
 ↓
AuthRepository
 ↓
AuthRemoteDatasource
 ↓
Supabase Auth
```

### Task Management Flow

```text
Create Task
 ↓
HomeNotifier
 ↓
CreateTaskUseCase
 ↓
HomeRepository
 ↓
HomeRemoteDatasource
 ↓
Supabase Database
```

---

# Supabase Configuration Steps

## 1. Create Supabase Project

Create a new project from:

https://supabase.com

---

## 2. Enable Authentication

Navigate to:

```text
Authentication
→ Providers
```

Enable:

* Email Authentication
* Google Authentication

---

## 3. Create Tasks Table

Execute the following SQL:

```sql
create table tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  description text not null,
  status text not null,
  start_date timestamp,
  end_date timestamp,
  created_at timestamp default now()
);
```

---

## 6. Get Project Credentials

Navigate to:

```text
Project Settings
→ API
```

Copy:

```text
Project URL
Publishable Key
```

Add them to the `.env` file.

---

## Features Implemented

### Authentication

* Email Login
* Google Login
* Logout
* Session Persistence

### Task Management

* Create Task
* View Tasks
* Update Task
* Delete Task
* Mark Task as Completed

### UI Features

* Responsive Design
* Task Status Filtering
* Today / Earlier Task Grouping
* Bottom Sheet Create & Update Form
* Delete Confirmation Dialog

---

## Packages Used

```yaml
flutter_riverpod
go_router
supabase_flutter
flutter_dotenv
intl
flutter_svg
```

---

## Future Improvements

* Loading Skeletons
* Forgot Password
* Task Search
* Task Sorting
* Offline Support
* Push Notifications
* Profile Management

---
