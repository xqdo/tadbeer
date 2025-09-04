import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/hive_boxes.dart';
import '../../data/hive_adapters/task_models.dart';
import '../../data/hive_adapters/settings_models.dart';

class HiveService {
  static HiveService? _instance;
  static HiveService get instance => _instance ??= HiveService._();
  HiveService._();

  /// Initialize Hive with all adapters and boxes
  static Future<void> init() async {
    // Initialize Hive
    await Hive.initFlutter();

    // Register all type adapters
    _registerAdapters();

    // Open all required boxes
    await _openBoxes();
    
    // Initialize default data if needed
    await _initializeDefaultData();
  }

  /// Register all Hive type adapters
  static void _registerAdapters() {
    // Task related adapters
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(TaskPriorityAdapter());
    Hive.registerAdapter(TaskStatusAdapter());
    Hive.registerAdapter(RecurrencePatternAdapter());
    Hive.registerAdapter(RecurrenceTypeAdapter());
    
    // Settings related adapters
    Hive.registerAdapter(AppSettingsAdapter());
    Hive.registerAdapter(TaskSortByAdapter());
    Hive.registerAdapter(TaskCategoryAdapter());
    
    // TODO: Add more adapters as we implement other modules
  }

  /// Open all required Hive boxes
  static Future<void> _openBoxes() async {
    // Open core boxes first
    await Future.wait([
      Hive.openBox<Task>(HiveBoxes.tasks),
      Hive.openBox<AppSettings>(HiveBoxes.settings),
      Hive.openBox<TaskCategory>(HiveBoxes.categories),
    ]);

    // Note: Other boxes will be opened as we implement their features
    // This prevents unnecessary resource usage in Phase 1
  }

  /// Initialize default data for first app launch
  static Future<void> _initializeDefaultData() async {
    await _initializeDefaultSettings();
    await _initializeDefaultCategories();
  }

  /// Initialize default app settings
  static Future<void> _initializeDefaultSettings() async {
    final settingsBox = Hive.box<AppSettings>(HiveBoxes.settings);
    
    if (settingsBox.isEmpty) {
      final defaultSettings = AppSettings();
      await settingsBox.put('main', defaultSettings);
    }
  }

  /// Initialize default task categories
  static Future<void> _initializeDefaultCategories() async {
    final categoriesBox = Hive.box<TaskCategory>(HiveBoxes.categories);
    
    if (categoriesBox.isEmpty) {
      final defaultCategories = [
        TaskCategory(
          id: 'work',
          name: 'Work',
          color: '#2196F3',
          iconCodePoint: 0xe844, // work icon
          isDefault: true,
          createdAt: DateTime.now(),
        ),
        TaskCategory(
          id: 'personal',
          name: 'Personal',
          color: '#4CAF50',
          iconCodePoint: 0xe7fd, // person icon
          isDefault: true,
          createdAt: DateTime.now(),
        ),
        TaskCategory(
          id: 'health',
          name: 'Health',
          color: '#FF5722',
          iconCodePoint: 0xe550, // favorite icon
          isDefault: true,
          createdAt: DateTime.now(),
        ),
        TaskCategory(
          id: 'learning',
          name: 'Learning',
          color: '#9C27B0',
          iconCodePoint: 0xe80c, // school icon
          isDefault: true,
          createdAt: DateTime.now(),
        ),
        TaskCategory(
          id: 'spiritual',
          name: 'Spiritual',
          color: '#006C5F',
          iconCodePoint: 0xe7e2, // mosque/spiritual icon
          isDefault: true,
          createdAt: DateTime.now(),
        ),
      ];

      for (final category in defaultCategories) {
        await categoriesBox.put(category.id, category);
      }
    }
  }

  /// Get a specific box
  static Box<T> getBox<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

  /// Close all boxes and clear Hive
  static Future<void> dispose() async {
    await Hive.close();
  }

  /// Get all tasks
  static List<Task> getAllTasks() {
    final box = getBox<Task>(HiveBoxes.tasks);
    return box.values.toList();
  }

  /// Get app settings
  static AppSettings getSettings() {
    final box = getBox<AppSettings>(HiveBoxes.settings);
    return box.get('main') ?? AppSettings();
  }

  /// Save app settings
  static Future<void> saveSettings(AppSettings settings) async {
    final box = getBox<AppSettings>(HiveBoxes.settings);
    await box.put('main', settings);
  }

  /// Get all categories
  static List<TaskCategory> getAllCategories() {
    final box = getBox<TaskCategory>(HiveBoxes.categories);
    return box.values.toList();
  }
}