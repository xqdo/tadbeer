# Technical Plan for Personal Tadbeer App

This document outlines the technical specifications and architectural considerations for the Personal Tadbeer mobile application. The goal is to provide a clear roadmap for development, focusing on a robust, scalable, and maintainable codebase.

## 1. Tech Stack

- **Flutter (UI Framework)**: Chosen for its ability to build natively compiled applications for mobile, web, and desktop from a single codebase. Flutter's declarative UI approach and rich set of pre-built widgets accelerate development and ensure a consistent user experience across platforms. Material 3 design principles will be strictly adhered to for a modern and intuitive interface.

- **Riverpod (State Management)**: A robust and testable state-management solution for Flutter. Riverpod offers compile-time safety, immutability, and a clear separation of concerns, making it ideal for managing application-wide state, including data from Hive and user preferences. Its provider system allows for efficient dependency injection and easy testing of individual components.

- **Hive (Local Database)**: A lightweight and fast key-value database for Flutter and Dart. Hive is selected for its simplicity, high performance, and lack of boilerplate code, making it suitable for storing structured and unstructured data locally within the personal Tadbeer app. It provides a straightforward API for data persistence and retrieval.

- **GoRouter (Navigation)**: A declarative routing package for Flutter that simplifies complex navigation flows. GoRouter enables deep linking, URL-based navigation, and a clear separation of navigation logic from UI components. This ensures a predictable and maintainable navigation structure as the application grows.

- **SharedPreferences (Settings/Preferences)**: A simple key-value store for persisting small amounts of data, such as user preferences and settings. SharedPreferences is ideal for lightweight, non-critical data that doesn't require the full capabilities of a database like Hive. It will be used for theme settings, notification preferences, and local app lock status.

## 2. Data Model (Hive Boxes)

The application's data will be organized into distinct Hive boxes, each representing a specific domain or module. This approach ensures data integrity, efficient querying, and modularity.

- `tasksBox`: Stores all task-related data. Each task object will include:
  - `id` (String/UUID): Unique identifier for the task.
  - `title` (String): A concise description of the task.
  - `notes` (String): Detailed notes or additional information about the task.
  - `dueDate` (DateTime): The target completion date for the task.
  - `priority` (Enum: `Low`, `Medium`, `High`): The importance level of the task.
  - `status` (Enum: `Todo`, `Doing`, `Done`): The current state of the task.
  - `created` (DateTime): Timestamp indicating when the task was created.

- `timeBox`: Manages manual time tracking sessions. Each session will include:
  - `id` (String/UUID): Unique identifier for the time session.
  - `startTime` (DateTime): The start time of the session.
  - `endTime` (DateTime): The end time of the session.
  - `label` (String, optional): A descriptive label for the session.
  - `taskId` (String, optional): Reference to a `tasksBox` ID if the session is linked to a specific task.

- `usageBox`: Records application usage statistics. Each entry will include:
  - `packageName` (String): The package name of the used application.
  - `startAt` (DateTime): The start time of the application usage.
  - `endAt` (DateTime): The end time of the application usage.

- `financeBox`: Stores financial transactions and categories. Each transaction will include:
  - `id` (String/UUID): Unique identifier for the transaction.
  - `amount` (double): The monetary value of the transaction.
  - `category` (String): The category of the transaction (e.g., Food, Transport, Salary).
  - `type` (Enum: `Income`, `Expense`): The type of transaction.
  - `note` (String, optional): Any additional notes for the transaction.
  - `date` (DateTime): The date of the transaction.

- `prayerBox`: Records daily obligatory prayer completion status. Each entry will include:
  - `date` (DateTime): The date for which the prayer status is recorded.
  - `fajrStatus` (Enum: `Done`, `Missed`): Status for Fajr prayer.
  - `dhuhrStatus` (Enum: `Done`, `Missed`): Status for Dhuhr prayer.
  - `asrStatus` (Enum: `Done`, `Missed`): Status for Asr prayer.
  - `maghribStatus` (Enum: `Done`, `Missed`): Status for Maghrib prayer.
  - `ishaStatus` (Enum: `Done`, `Missed`): Status for Isha prayer.

- `qadaBox`: Manages the backlog, repayment plan, and goal setting for missed prayers. This box will track:
  - `prayerType` (Enum: `Fajr`, `Dhuhr`, `Asr`, `Maghrib`, `Isha`): The type of prayer.
  - `missedCount` (int): Total count of missed prayers for that type.
  - `repaidCount` (int): Total count of repaid prayers for that type.
  - `dailyTarget` (int): The daily target for repaying missed prayers.
  - `goalTarget` (int, optional): The total number of prayers targeted for repayment in a specific period.
  - `goalStartDate` (DateTime, optional): The start date of the repayment goal period.
  - `goalEndDate` (DateTime, optional): The end date of the repayment goal period.
  - `goalProgress` (int, optional): The number of prayers repaid towards the current goal.

- `settingsBox`: A fallback for structured application preferences. While `SharedPreferences` will handle most simple settings, `settingsBox` can be used for more complex, structured preferences that benefit from Hive's object storage capabilities.

## 3. App Architecture

The application will follow a modular and layered architecture to ensure maintainability, testability, and scalability. The structure is inspired by clean architecture principles, separating concerns into presentation, application, and data layers.

```
lib/
  main.dart
  app/ # Application-wide configurations and services
    router.dart # GoRouter configuration for all routes
    theme.dart # Material 3 theme definitions (colors, typography, shapes)
    providers.dart # Centralized Riverpod providers for app-wide state
  core/ # Reusable widgets, utilities, and common functionalities
    widgets/ # Generic UI components used across features
    utils/ # Helper functions, extensions, and constants
  data/ # Data sources and repositories
    hive_adapters/ # Hive TypeAdapters for custom objects
    repositories/ # Abstraction layer for data access (e.g., TaskRepository, FinanceRepository)
  features/ # Feature-specific modules, each with its own architecture
    tasks/ # Task management module
      presentation/ # UI components (screens, widgets) for tasks
      application/ # Business logic and Riverpod providers for tasks
      data/ # Data models and Hive box interactions specific to tasks
    time/ # Time management module
    finance/ # Financial tracking module
    religious/ # Religious tracking module
    settings/ # Application settings module
  services/ # External service integrations
    notifications/ # Local notification service implementation
    usage_tracker/ # Android UsageStatsManager integration for app usage
    backup_service/ # Logic for backing up and restoring Hive data
```

- **Riverpod Providers**: Each `application/` folder within a feature will contain Riverpod providers responsible for managing the state and business logic of that specific feature. This promotes a clear separation of concerns and makes testing easier.
- **Hive Adapters**: Custom Hive `TypeAdapter` implementations will reside in `data/hive_adapters/` to enable storing custom Dart objects in Hive boxes.
- **Repositories**: The `repositories/` layer will provide an abstract interface for data access, encapsulating the underlying Hive operations. This allows for easier swapping of data sources in the future and simplifies unit testing of business logic.

## 4. Navigation (GoRouter)

GoRouter will be used to manage the application's navigation flow. The following routes will be defined:

- `/`: The root route, leading to the main Dashboard screen.
- `/tasks`: Navigates to the Tasks module, which will include sub-screens for Inbox, Today, and Upcoming tasks.
- `/time`: Navigates to the Time Management module, displaying time tracking and app usage statistics.
- `/finance`: Navigates to the Finance module, providing access to transactions and financial summaries.
- `/religious`: Navigates to the Religious module, featuring daily prayer tracking and the Qadā’ planner.
- `/settings`: Navigates to the application settings and backup options.

A **Bottom Navigation Bar** will be implemented for quick access to the four main modules: Tasks, Time, Finance, and Religious. This ensures a consistent and user-friendly navigation experience.

## 5. Theme & UI (Material 3)

The application's visual design will strictly adhere to Material 3 guidelines, ensuring a modern, accessible, and aesthetically pleasing user interface.

- **Theme Mode**: The application will default to the system's theme mode (light/dark) but will provide a toggle in the settings for manual override.

- **Colors**:
  - **Primary**: `#006C5F` (Teal Green). This color is chosen for its balanced professional and calm aesthetic, serving as the dominant color for interactive elements, headers, and primary actions.
  - **Secondary**: `#FFB300` (Amber). This warm color will be used for accents, highlights, and to draw attention to specific elements or actions, providing visual contrast to the primary color.
  - **Error**: Material default red. Standard Material Design error color for indicating errors or warnings.

- **Shapes**: All UI elements will feature rounded corners with a consistent radius of `12dp`. This contributes to a soft, modern, and friendly visual appeal.

- **Typography**: A carefully selected typography scale will be applied to ensure readability and visual hierarchy.
  - `HeadlineMedium`: Will be used for prominent numerical displays on the dashboard, such as total time tracked, financial sums, and prayer backlog counts.
  - `BodyLarge`: Applied to main content text, including task titles and category names, ensuring clear readability.
  - `LabelMedium`: Used for secondary information, such as dates, amounts, and small labels, providing contextual details without overwhelming the user.

- **Dark Mode**: A pure Material 3 dark scheme will be implemented, leveraging dynamic surface blending to create a visually comfortable and energy-efficient experience in low-light environments.

## 6. Notifications

Local notifications will be implemented using `flutter_local_notifications` to provide timely and relevant alerts to the user. Notifications will be categorized into distinct channels for better management and user control.

- **Tasks Channel (`tasks_channel`)**: For due date reminders and task-related alerts.
- **Time Channel (`time_channel`)**: For daily summaries of screen time usage.
- **Finance Channel (`finance_channel`)**: An optional reminder to "Log expenses?" at night, promoting consistent financial tracking.
- **Religious Channel (`religious_channel`)**: For obligatory prayer nudges and daily Qadā' repayment plan reminders.

**Additional Notification Enhancements:**
- **Smart Scheduling**: Implement adaptive scheduling based on user behavior patterns (e.g., don't send task reminders during typical sleep hours).
- **Priority-Based Alerts**: Different notification sounds/vibration patterns based on task priority or prayer times.
- **Weekly/Monthly Summaries**: Send periodic progress reports across all modules to encourage consistency.

## 7. Roadmap (First Build)

This roadmap outlines a phased approach for the initial development of the Tadbeer application, targeting a Minimum Viable Product (MVP) within four weeks.

**Week 1: Foundation & Core Tasks**
- **Project Setup**: Scaffold the Flutter project, configure necessary build settings, and integrate essential dependencies: `hive`, `riverpod`, `go_router`, `shared_preferences`, and `flutter_local_notifications`.
- **Tasks Module (MVP)**: Implement the core functionality for task management, including the Hive box setup for tasks and basic CRUD (Create, Read, Update, Delete) operations through a user interface.
- **Theme & Navigation**: Implement the Material 3 theme, including color schemes, typography, and shapes. Set up the basic navigation structure using GoRouter, including the bottom navigation bar and initial routes.

**Week 2: Time & Finance Modules**
- **Time Module**: Develop manual timer functionality, allowing users to start, stop, and label time sessions. Integrate with the Android `UsageStatsManager` API (if applicable for Android) to track app usage statistics.
- **Finance Module**: Implement basic transaction entry (income/expense) and display a monthly summary, including totals and top 5 categories.

**Week 3: Religious & Utilities**
- **Religious Module**: Implement the daily obligatory prayer tracker, the Qadā’ (missed prayers) backlog planner, and the Qadā’ goal setting feature. This includes tracking daily prayers, calculating the remaining Qadā’, and allowing users to set and track progress towards specific repayment goals over a defined period.
- **Notifications**: Integrate and configure `flutter_local_notifications` for all defined channels (tasks, time, finance, religious), setting up relevant reminders and summaries.
- **Settings**: Implement core application settings, including theme toggle, local app lock (PIN/biometric), and basic backup/restore functionality for Hive boxes.

**Week 4: Polish & Release Preparation**
- **Dashboard Refinement**: Polish the main Dashboard screen to provide a comprehensive overview of tasks, time, finance, and religious progress.
- **Quality Assurance (QA)**: Conduct thorough testing of all implemented features, addressing bugs and ensuring a smooth user experience.
- **Performance Optimization**: Profile and optimize app performance, especially Hive database operations and UI rendering.
- **APK Export**: Prepare and export the Android Application Package (APK) for personal use and testing.

## 8. Technical Improvements & Best Practices

**Code Quality & Maintainability:**
- **Dependency Injection**: Use Riverpod's dependency injection capabilities to make services easily testable and swappable.
- **Error Handling**: Implement comprehensive error handling with user-friendly error messages and fallback mechanisms.
- **Logging**: Add structured logging using packages like `logger` for debugging and monitoring.
- **Code Generation**: Utilize `build_runner` with packages like `freezed` for immutable data classes and `json_annotation` for JSON serialization.

**Data Management Enhancements:**
- **Data Validation**: Implement input validation for all user data before storing in Hive.
- **Migration Strategy**: Plan for future schema changes with version-controlled Hive box migrations.
- **Backup Automation**: Consider implementing automated daily/weekly backups to local storage or cloud services.
- **Data Export**: Add functionality to export data in standard formats (CSV, JSON) for external analysis.

**Performance & Scalability:**
- **Lazy Loading**: Implement lazy loading for large datasets to improve app startup time.
- **Pagination**: Add pagination for large lists (tasks, transactions) to maintain smooth scrolling.
- **Memory Management**: Proper disposal of controllers, subscriptions, and Hive boxes to prevent memory leaks.
- **Indexing**: Consider adding custom indexes to Hive boxes for faster queries on frequently searched fields.

**Security Considerations:**
- **Data Encryption**: Encrypt sensitive financial and personal data stored in Hive boxes.
- **Secure Storage**: Use `flutter_secure_storage` for storing encryption keys and sensitive app settings.
- **Biometric Authentication**: Implement proper biometric authentication with fallback options.
- **App Lock Timeout**: Add configurable auto-lock functionality after periods of inactivity.

**User Experience Enhancements:**
- **Onboarding**: Create a smooth first-time user experience with guided setup and feature introduction.
- **Accessibility**: Ensure compliance with accessibility guidelines (screen readers, high contrast, font scaling).
- **Offline-First Design**: Ensure all core functionality works without internet connectivity.
- **Gesture Support**: Add swipe gestures for quick actions (mark task complete, delete transaction).
- **Search & Filter**: Implement powerful search and filtering capabilities across all modules.

**Additional Features for Future Consideration:**
- **Data Analytics Dashboard**: Personal insights and trends across all tracked metrics.
- **Integration APIs**: Consider future integration with calendar apps, banking APIs, or fitness trackers.
- **Widget Support**: Android/iOS home screen widgets for quick data entry and status viewing.
- **Multi-language Support**: Implement internationalization (i18n) for broader accessibility.

