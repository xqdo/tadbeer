# Phase 2: Time Management & Finance Tracking (Week 2)

## Objective
Build comprehensive time tracking and financial management features to help monitor daily activities and personal expenses.

## Enhanced Database Design

### Time Management Schema

#### `timeSessionsBox` - Time Tracking Sessions
```dart
@HiveType(typeId: 4)
class TimeSession {
  @HiveField(0) String id;
  @HiveField(1) DateTime startTime;
  @HiveField(2) DateTime? endTime;
  @HiveField(3) String? activityName;
  @HiveField(4) String? taskId; // Link to tasks
  @HiveField(5) String? categoryId; // Work, Study, Personal, etc.
  @HiveField(6) String? notes;
  @HiveField(7) SessionType type; // Manual, Automatic, Pomodoro
  @HiveField(8) Duration? plannedDuration;
  @HiveField(9) int? productivityRating; // 1-5 scale
  @HiveField(10) List<String> tags;
  @HiveField(11) String? location;
  @HiveField(12) bool isBreak;
}
```

#### `appUsageBox` - Digital Wellbeing Tracking
```dart
@HiveType(typeId: 5)
class AppUsage {
  @HiveField(0) String packageName;
  @HiveField(1) String appName;
  @HiveField(2) DateTime date; // Day of usage
  @HiveField(3) Duration totalTime;
  @HiveField(4) int openCount; // Times app was opened
  @HiveField(5) Duration longestSession;
  @HiveField(6) List<UsageSession> sessions;
  @HiveField(7) String category; // Social, Productivity, Entertainment
  @HiveField(8) bool isProductiveApp;
}

@HiveType(typeId: 6)
class UsageSession {
  @HiveField(0) DateTime startTime;
  @HiveField(1) Duration duration;
  @HiveField(2) String? context; // What triggered the usage
}
```

### Finance Management Schema

#### `transactionsBox` - Financial Transactions
```dart
@HiveType(typeId: 7)
class Transaction {
  @HiveField(0) String id;
  @HiveField(1) double amount;
  @HiveField(2) String categoryId;
  @HiveField(3) TransactionType type; // Income, Expense, Transfer
  @HiveField(4) DateTime date;
  @HiveField(5) String? description;
  @HiveField(6) String? notes;
  @HiveField(7) PaymentMethod paymentMethod; // Cash, Card, Digital
  @HiveField(8) String? location;
  @HiveField(9) List<String>? tags;
  @HiveField(10) String? receiptPath; // Photo of receipt
  @HiveField(11) bool isRecurring;
  @HiveField(12) RecurrencePattern? recurrence;
  @HiveField(13) String currency; // Default: local currency
  @HiveField(14) bool isBusinessExpense;
}
```

#### `budgetBox` - Budget Management
```dart
@HiveType(typeId: 8)
class Budget {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2) String categoryId;
  @HiveField(3) double amount;
  @HiveField(4) BudgetPeriod period; // Weekly, Monthly, Yearly
  @HiveField(5) DateTime startDate;
  @HiveField(6) DateTime endDate;
  @HiveField(7) double spent;
  @HiveField(8) bool alertEnabled;
  @HiveField(9) double alertThreshold; // % of budget
  @HiveField(10) List<String> includeCategories;
  @HiveField(11) List<String> excludeCategories;
}
```

#### `financeCategoriesBox` - Expense Categories
```dart
@HiveType(typeId: 9)
class FinanceCategory {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2) String? parentCategoryId; // For subcategories
  @HiveField(3) String color;
  @HiveField(4) IconData icon;
  @HiveField(5) CategoryType type; // Income, Expense, Both
  @HiveField(6) bool isEssential; // Needs vs wants
  @HiveField(7) double monthlyBudget;
  @HiveField(8) List<String> keywords; // For auto-categorization
}
```

## Daily Tasks & Implementation

### Day 1: Time Management Foundation
- [ ] Create time tracking data models and Hive adapters
- [ ] Implement TimeRepository with session management
- [ ] Set up Riverpod providers for time tracking state
- [ ] Create basic timer UI components
- [ ] Implement start/stop/pause functionality

### Day 2: Advanced Time Features
- [ ] Build Pomodoro timer with customizable intervals
- [ ] Implement activity categorization system
- [ ] Create time tracking history view
- [ ] Add productivity rating system
- [ ] Implement time goals and tracking

### Day 3: App Usage Analytics
- [ ] Integrate Android Usage Stats API
- [ ] Create app usage data collection service
- [ ] Build usage analytics dashboard
- [ ] Implement daily/weekly/monthly usage reports
- [ ] Add screen time goals and alerts

### Day 4: Finance Model Implementation
- [ ] Create transaction and budget data models
- [ ] Implement FinanceRepository with CRUD operations
- [ ] Set up expense categorization system
- [ ] Create transaction validation logic
- [ ] Implement currency formatting utilities

### Day 5: Finance UI Development
- [ ] Build transaction entry form with validation
- [ ] Create expense/income tracking interface
- [ ] Implement category management UI
- [ ] Design budget creation and tracking interface
- [ ] Add receipt photo capture functionality

### Day 6: Finance Analytics & Reports
- [ ] Create monthly expense summary
- [ ] Build category-wise spending analysis
- [ ] Implement budget vs actual spending charts
- [ ] Add income/expense trends visualization
- [ ] Create financial health indicators

### Day 7: Integration & Polish
- [ ] Integrate time and finance modules
- [ ] Link time sessions to billable/expense tracking
- [ ] Polish UI/UX across both modules
- [ ] Add data export capabilities
- [ ] Optimize performance for large datasets

## Key Features Delivered

### Time Management
1. **Manual Time Tracking**
   - Start/stop timers for activities
   - Categorize time sessions
   - Add notes and productivity ratings
   - Link sessions to tasks

2. **Pomodoro Timer**
   - Customizable work/break intervals
   - Session tracking and statistics
   - Productivity insights

3. **App Usage Monitoring**
   - Daily screen time tracking
   - App-wise usage breakdown
   - Digital wellbeing insights
   - Usage goals and alerts

### Finance Management
1. **Transaction Tracking**
   - Quick expense/income entry
   - Category-based organization
   - Receipt photo storage
   - Recurring transaction templates

2. **Budget Management**
   - Monthly/weekly budget creation
   - Real-time budget tracking
   - Overspending alerts
   - Category-wise budget allocation

3. **Financial Analytics**
   - Monthly spending summaries
   - Category-wise breakdowns
   - Income vs expense trends
   - Financial goals tracking

## Success Metrics
- [ ] Can track 8+ hours of daily activities accurately
- [ ] Transaction entry takes less than 30 seconds
- [ ] App usage data syncs reliably
- [ ] Budget calculations are accurate
- [ ] Analytics load in under 1 second

## Personal Life Management Features
- **Energy Management**: Track energy levels throughout the day
- **Location-Based Tracking**: Automatic categorization based on location
- **Smart Notifications**: Context-aware reminders for logging expenses
- **Weekly Reviews**: Automated summaries of time and money patterns
- **Goal Integration**: Link financial goals to time investment

## Integration Points with Phase 1
- Link time sessions to specific tasks
- Track billable hours for freelance work
- Monitor time spent on different life areas
- Financial impact of productivity improvements

## Phase 2 Completion Checklist
- [ ] All time tracking features functional
- [ ] Finance management core complete
- [ ] App usage monitoring working
- [ ] Data visualization implemented
- [ ] Performance optimized for daily use
- [ ] Integration with Phase 1 tasks complete