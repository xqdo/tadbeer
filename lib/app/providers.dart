import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/hive_service.dart';
import '../data/hive_adapters/settings_models.dart';

/// Provider for app settings
final appSettingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  return AppSettingsNotifier();
});

/// State notifier for app settings
class AppSettingsNotifier extends StateNotifier<AppSettings> {
  AppSettingsNotifier() : super(HiveService.getSettings());

  /// Update theme mode
  Future<void> updateThemeMode(String themeMode) async {
    final newSettings = AppSettings(
      themeMode: themeMode,
      biometricEnabled: state.biometricEnabled,
      pinCode: state.pinCode,
      autoLockTimeoutMinutes: state.autoLockTimeoutMinutes,
      notificationsEnabled: state.notificationsEnabled,
      dailyReviewTime: state.dailyReviewTime,
      priorityTags: state.priorityTags,
      showCompletedTasks: state.showCompletedTasks,
      defaultSortBy: state.defaultSortBy,
      dailyTaskGoal: state.dailyTaskGoal,
      weeklyReviewEnabled: state.weeklyReviewEnabled,
      currency: state.currency,
      language: state.language,
      timezone: state.timezone,
    );
    
    state = newSettings;
    await HiveService.saveSettings(newSettings);
  }

  /// Update notification settings
  Future<void> updateNotifications(bool enabled) async {
    final newSettings = AppSettings(
      themeMode: state.themeMode,
      biometricEnabled: state.biometricEnabled,
      pinCode: state.pinCode,
      autoLockTimeoutMinutes: state.autoLockTimeoutMinutes,
      notificationsEnabled: enabled,
      dailyReviewTime: state.dailyReviewTime,
      priorityTags: state.priorityTags,
      showCompletedTasks: state.showCompletedTasks,
      defaultSortBy: state.defaultSortBy,
      dailyTaskGoal: state.dailyTaskGoal,
      weeklyReviewEnabled: state.weeklyReviewEnabled,
      currency: state.currency,
      language: state.language,
      timezone: state.timezone,
    );
    
    state = newSettings;
    await HiveService.saveSettings(newSettings);
  }

  /// Update daily task goal
  Future<void> updateDailyTaskGoal(int goal) async {
    final newSettings = AppSettings(
      themeMode: state.themeMode,
      biometricEnabled: state.biometricEnabled,
      pinCode: state.pinCode,
      autoLockTimeoutMinutes: state.autoLockTimeoutMinutes,
      notificationsEnabled: state.notificationsEnabled,
      dailyReviewTime: state.dailyReviewTime,
      priorityTags: state.priorityTags,
      showCompletedTasks: state.showCompletedTasks,
      defaultSortBy: state.defaultSortBy,
      dailyTaskGoal: goal,
      weeklyReviewEnabled: state.weeklyReviewEnabled,
      currency: state.currency,
      language: state.language,
      timezone: state.timezone,
    );
    
    state = newSettings;
    await HiveService.saveSettings(newSettings);
  }

  /// Update biometric lock settings
  Future<void> updateBiometric(bool enabled, String? pinCode) async {
    final newSettings = AppSettings(
      themeMode: state.themeMode,
      biometricEnabled: enabled,
      pinCode: pinCode,
      autoLockTimeoutMinutes: state.autoLockTimeoutMinutes,
      notificationsEnabled: state.notificationsEnabled,
      dailyReviewTime: state.dailyReviewTime,
      priorityTags: state.priorityTags,
      showCompletedTasks: state.showCompletedTasks,
      defaultSortBy: state.defaultSortBy,
      dailyTaskGoal: state.dailyTaskGoal,
      weeklyReviewEnabled: state.weeklyReviewEnabled,
      currency: state.currency,
      language: state.language,
      timezone: state.timezone,
    );
    
    state = newSettings;
    await HiveService.saveSettings(newSettings);
  }
}