// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 10;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
      themeMode: fields[0] as String,
      biometricEnabled: fields[1] as bool,
      pinCode: fields[2] as String?,
      autoLockTimeoutMinutes: fields[3] as int,
      notificationsEnabled: fields[4] as bool,
      dailyReviewTime: fields[5] as String,
      priorityTags: (fields[6] as List).cast<String>(),
      showCompletedTasks: fields[7] as bool,
      defaultSortBy: fields[8] as TaskSortBy,
      dailyTaskGoal: fields[9] as int,
      weeklyReviewEnabled: fields[10] as bool,
      currency: fields[11] as String,
      language: fields[12] as String,
      timezone: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.themeMode)
      ..writeByte(1)
      ..write(obj.biometricEnabled)
      ..writeByte(2)
      ..write(obj.pinCode)
      ..writeByte(3)
      ..write(obj.autoLockTimeoutMinutes)
      ..writeByte(4)
      ..write(obj.notificationsEnabled)
      ..writeByte(5)
      ..write(obj.dailyReviewTime)
      ..writeByte(6)
      ..write(obj.priorityTags)
      ..writeByte(7)
      ..write(obj.showCompletedTasks)
      ..writeByte(8)
      ..write(obj.defaultSortBy)
      ..writeByte(9)
      ..write(obj.dailyTaskGoal)
      ..writeByte(10)
      ..write(obj.weeklyReviewEnabled)
      ..writeByte(11)
      ..write(obj.currency)
      ..writeByte(12)
      ..write(obj.language)
      ..writeByte(13)
      ..write(obj.timezone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskCategoryAdapter extends TypeAdapter<TaskCategory> {
  @override
  final int typeId = 12;

  @override
  TaskCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskCategory(
      id: fields[0] as String,
      name: fields[1] as String,
      color: fields[2] as String,
      iconCodePoint: fields[3] as int,
      isDefault: fields[4] as bool,
      createdAt: fields[5] as DateTime,
      description: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskCategory obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.iconCodePoint)
      ..writeByte(4)
      ..write(obj.isDefault)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskSortByAdapter extends TypeAdapter<TaskSortBy> {
  @override
  final int typeId = 11;

  @override
  TaskSortBy read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaskSortBy.dueDate;
      case 1:
        return TaskSortBy.priority;
      case 2:
        return TaskSortBy.created;
      case 3:
        return TaskSortBy.alphabetical;
      case 4:
        return TaskSortBy.energyLevel;
      default:
        return TaskSortBy.dueDate;
    }
  }

  @override
  void write(BinaryWriter writer, TaskSortBy obj) {
    switch (obj) {
      case TaskSortBy.dueDate:
        writer.writeByte(0);
        break;
      case TaskSortBy.priority:
        writer.writeByte(1);
        break;
      case TaskSortBy.created:
        writer.writeByte(2);
        break;
      case TaskSortBy.alphabetical:
        writer.writeByte(3);
        break;
      case TaskSortBy.energyLevel:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskSortByAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
