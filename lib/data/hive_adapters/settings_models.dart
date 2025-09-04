import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'settings_models.g.dart';

@HiveType(typeId: 10)
class AppSettings extends HiveObject {
  @HiveField(0)
  String themeMode; // 'system', 'light', 'dark'

  @HiveField(1)
  bool biometricEnabled;

  @HiveField(2)
  String? pinCode;

  @HiveField(3)
  int autoLockTimeoutMinutes;

  @HiveField(4)
  bool notificationsEnabled;

  @HiveField(5)
  String dailyReviewTime; // '20:00' format

  @HiveField(6)
  List<String> priorityTags;

  @HiveField(7)
  bool showCompletedTasks;

  @HiveField(8)
  TaskSortBy defaultSortBy;

  @HiveField(9)
  int dailyTaskGoal;

  @HiveField(10)
  bool weeklyReviewEnabled;

  @HiveField(11)
  String currency; // 'USD', 'EUR', etc.

  @HiveField(12)
  String language; // 'en', 'ar', etc.

  @HiveField(13)
  String timezone;

  AppSettings({
    this.themeMode = 'system',
    this.biometricEnabled = false,
    this.pinCode,
    this.autoLockTimeoutMinutes = 5,
    this.notificationsEnabled = true,
    this.dailyReviewTime = '20:00',
    this.priorityTags = const [],
    this.showCompletedTasks = true,
    this.defaultSortBy = TaskSortBy.dueDate,
    this.dailyTaskGoal = 5,
    this.weeklyReviewEnabled = true,
    this.currency = 'USD',
    this.language = 'en',
    this.timezone = 'UTC',
  });

  // Helper methods
  ThemeMode get themeModeEnum {
    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  TimeOfDay get dailyReviewTimeOfDay {
    final parts = dailyReviewTime.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  Duration get autoLockTimeout => Duration(minutes: autoLockTimeoutMinutes);
}

@HiveType(typeId: 11)
enum TaskSortBy {
  @HiveField(0)
  dueDate,

  @HiveField(1)
  priority,

  @HiveField(2)
  created,

  @HiveField(3)
  alphabetical,

  @HiveField(4)
  energyLevel,
}

@HiveType(typeId: 12)
class TaskCategory extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String color; // Hex color code

  @HiveField(3)
  int iconCodePoint;

  @HiveField(4)
  bool isDefault;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  String? description;

  TaskCategory({
    required this.id,
    required this.name,
    required this.color,
    required this.iconCodePoint,
    this.isDefault = false,
    required this.createdAt,
    this.description,
  });

  // Helper methods
  Color get colorValue => Color(int.parse(color.replaceFirst('#', '0xFF')));
  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');
}