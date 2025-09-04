import 'package:hive/hive.dart';

part 'task_models.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  DateTime? dueDate;

  @HiveField(4)
  TaskPriority priority;

  @HiveField(5)
  TaskStatus status;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime? completedAt;

  @HiveField(8)
  List<String> tags;

  @HiveField(9)
  String? projectId;

  @HiveField(10)
  Duration? estimatedTime;

  @HiveField(11)
  int? energyLevel; // 1-5 scale for required energy

  @HiveField(12)
  String? location;

  @HiveField(13)
  List<String>? attachments;

  @HiveField(14)
  bool isRecurring;

  @HiveField(15)
  RecurrencePattern? recurrence;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.dueDate,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.todo,
    required this.createdAt,
    this.completedAt,
    this.tags = const [],
    this.projectId,
    this.estimatedTime,
    this.energyLevel,
    this.location,
    this.attachments,
    this.isRecurring = false,
    this.recurrence,
  });

  // Helper methods
  bool get isCompleted => status == TaskStatus.done;
  bool get isOverdue => dueDate != null && 
      DateTime.now().isAfter(dueDate!) && 
      status != TaskStatus.done;
  
  Duration get timeUntilDue {
    if (dueDate == null) return Duration.zero;
    return dueDate!.difference(DateTime.now());
  }
}

@HiveType(typeId: 2)
enum TaskPriority {
  @HiveField(0)
  low,

  @HiveField(1)
  medium,

  @HiveField(2)
  high,

  @HiveField(3)
  urgent,
}

@HiveType(typeId: 3)
enum TaskStatus {
  @HiveField(0)
  todo,

  @HiveField(1)
  inProgress,

  @HiveField(2)
  done,

  @HiveField(3)
  archived,
}

@HiveType(typeId: 4)
class RecurrencePattern extends HiveObject {
  @HiveField(0)
  RecurrenceType type;

  @HiveField(1)
  int interval; // Every X days/weeks/months

  @HiveField(2)
  List<int>? daysOfWeek; // 0-6 for weekly recurrence

  @HiveField(3)
  int? dayOfMonth; // For monthly recurrence

  @HiveField(4)
  DateTime? endDate;

  @HiveField(5)
  int? occurrences; // Max number of occurrences

  RecurrencePattern({
    required this.type,
    this.interval = 1,
    this.daysOfWeek,
    this.dayOfMonth,
    this.endDate,
    this.occurrences,
  });
}

@HiveType(typeId: 5)
enum RecurrenceType {
  @HiveField(0)
  daily,

  @HiveField(1)
  weekly,

  @HiveField(2)
  monthly,

  @HiveField(3)
  yearly,
}