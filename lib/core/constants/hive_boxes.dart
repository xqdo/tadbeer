/// Hive box names for the Tadbeer application
class HiveBoxes {
  // Core boxes
  static const String tasks = 'tasks_box';
  static const String settings = 'settings_box';
  static const String categories = 'categories_box';
  
  // Time tracking boxes
  static const String timeSessions = 'time_sessions_box';
  static const String appUsage = 'app_usage_box';
  
  // Finance boxes
  static const String transactions = 'transactions_box';
  static const String budget = 'budget_box';
  static const String financeCategories = 'finance_categories_box';
  
  // Religious boxes
  static const String dailyPrayers = 'daily_prayers_box';
  static const String qadaPrayers = 'qada_prayers_box';
  static const String dhikrSessions = 'dhikr_sessions_box';
  static const String islamicCalendar = 'islamic_calendar_box';
  static const String spiritualGoals = 'spiritual_goals_box';
  
  // Advanced features boxes (Phase 4)
  static const String dashboardData = 'dashboard_data_box';
  static const String backup = 'backup_box';
  static const String habitTracker = 'habit_tracker_box';
  static const String lifeReviews = 'life_reviews_box';
  static const String userProfile = 'user_profile_box';
  
  /// List of all box names for initialization
  static const List<String> allBoxes = [
    tasks,
    settings,
    categories,
    timeSessions,
    appUsage,
    transactions,
    budget,
    financeCategories,
    dailyPrayers,
    qadaPrayers,
    dhikrSessions,
    islamicCalendar,
    spiritualGoals,
    dashboardData,
    backup,
    habitTracker,
    lifeReviews,
    userProfile,
  ];
}