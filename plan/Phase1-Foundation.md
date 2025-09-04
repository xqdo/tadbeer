# Phase 1: Foundation & Core Tasks (Week 1)

## Objective
Establish the foundation of the Tadbeer app with core task management, basic UI framework, and essential infrastructure.

## Database Design - Enhanced

### Hive Boxes Structure

#### `tasksBox` - Task Management
```dart
@HiveType(typeId: 1)
class Task {
  @HiveField(0) String id;
  @HiveField(1) String title;
  @HiveField(2) String? description;
  @HiveField(3) DateTime? dueDate;
  @HiveField(4) TaskPriority priority; // Low, Medium, High, Urgent
  @HiveField(5) TaskStatus status; // Todo, InProgress, Done, Archived
  @HiveField(6) DateTime createdAt;
  @HiveField(7) DateTime? completedAt;
  @HiveField(8) List<String> tags; // For categorization
  @HiveField(9) String? projectId; // Link to projects (future)
  @HiveField(10) Duration? estimatedTime;
  @HiveField(11) int? energyLevel; // 1-5 scale for required energy
  @HiveField(12) String? location; // Where task should be done
  @HiveField(13) List<String>? attachments; // File paths
  @HiveField(14) bool isRecurring;
  @HiveField(15) RecurrencePattern? recurrence;
}
```

#### `settingsBox` - Enhanced App Settings
```dart
@HiveType(typeId: 2)
class AppSettings {
  @HiveField(0) ThemeMode themeMode;
  @HiveField(1) bool biometricEnabled;
  @HiveField(2) String? pinCode;
  @HiveField(3) Duration autoLockTimeout;
  @HiveField(4) bool notificationsEnabled;
  @HiveField(5) TimeOfDay dailyReviewTime;
  @HiveField(6) List<String> priorityTags;
  @HiveField(7) bool showCompletedTasks;
  @HiveField(8) TaskSortBy defaultSortBy;
  @HiveField(9) int dailyTaskGoal; // Personal daily target
  @HiveField(10) bool weeklyReviewEnabled;
}
```

#### `categoriesBox` - Task Categories
```dart
@HiveType(typeId: 3)
class TaskCategory {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2) String color; // Hex color code
  @HiveField(3) IconData icon;
  @HiveField(4) bool isDefault;
  @HiveField(5) DateTime createdAt;
}
```

## Daily Tasks & Implementation

### Day 1: Project Setup & Architecture
- [x] Initialize Flutter project structure
- [x] Set up dependencies (Riverpod, Hive, GoRouter, etc.)
- [ ] Create folder structure according to technical plan
  ```
  lib/
    app/
      router.dart
      theme.dart
      providers.dart
    core/
      widgets/
      utils/
      constants/
    data/
      hive_adapters/
      repositories/
    features/
      tasks/
        presentation/
        application/
        data/
  ```
- [ ] Initialize Hive database with boxes
- [ ] Set up theme system with Material 3

### Day 2: Core Task Models & Repository
- [ ] Create Hive adapters for Task, Category, Settings
- [ ] Implement TaskRepository with CRUD operations
- [ ] Set up Riverpod providers for state management
- [ ] Create basic validation for task data
- [ ] Implement data persistence layer

### Day 3: Basic Task UI Components
- [ ] Create TaskCard widget with Material 3 design
- [ ] Implement TaskList widget with filtering
- [ ] Build AddTaskDialog with form validation
- [ ] Create priority and status indicators
- [ ] Implement swipe actions (complete, delete)

### Day 4: Task Management Logic
- [ ] Implement task creation workflow
- [ ] Add task editing functionality  
- [ ] Create task filtering system (by status, priority, date)
- [ ] Implement task search functionality
- [ ] Add task sorting options

### Day 5: Navigation & Routing
- [ ] Set up GoRouter with bottom navigation
- [ ] Implement route guards for app lock
- [ ] Create smooth transitions between screens
- [ ] Set up deep linking structure
- [ ] Implement back navigation handling

### Day 6: Theme & Polish
- [ ] Implement Material 3 theme system
- [ ] Set up primary color (#006C5F) and secondary (#FFB300)
- [ ] Create dark/light theme switching
- [ ] Polish UI components with proper spacing
- [ ] Implement responsive design basics

### Day 7: Testing & Debug
- [ ] Write unit tests for TaskRepository
- [ ] Test task CRUD operations
- [ ] Debug UI issues and performance
- [ ] Test theme switching
- [ ] Prepare for Phase 2

## Key Features Delivered
1. **Task Management Core**
   - Create, edit, delete tasks
   - Set priorities and due dates
   - Mark tasks complete/incomplete
   - Basic categorization with tags

2. **User Interface**
   - Material 3 design system
   - Dark/light theme support
   - Responsive layout
   - Smooth animations

3. **Data Layer**
   - Hive database integration
   - Efficient data persistence
   - Basic backup/restore capability

4. **Navigation**
   - Bottom navigation bar
   - Smooth routing transitions
   - Deep linking foundation

## Success Metrics
- [ ] Can create and manage at least 20 tasks smoothly
- [ ] App launches in under 2 seconds
- [ ] All CRUD operations work reliably
- [ ] Theme switching works without restart
- [ ] No memory leaks during normal usage

## Technical Debt to Address in Phase 2
- Enhanced search with tags and filters
- Bulk task operations
- Task templates for common activities
- Performance optimization for large datasets
- Advanced UI animations

## Phase 1 Completion Checklist
- [ ] All core task management features working
- [ ] Material 3 theme fully implemented
- [ ] Database operations stable and tested
- [ ] Navigation system functional
- [ ] Code reviewed and refactored
- [ ] Documentation updated
- [ ] Git repository properly organized