import 'package:intl/intl.dart';
import 'package:techyspot_todo/features/home/domain/entites/task_entity.dart';

class TaskHelper {
  static String getDayName() {
    return DateFormat('EEEE').format(DateTime.now());
  }

  static List<TaskEntity> filterTasks(
    List<TaskEntity> tasks,
    int selectedFilter,
  ) {
    switch (selectedFilter) {
      case 1:
        return tasks.where((task) => task.status == 'todo').toList();

      case 2:
        return tasks.where((task) => task.status == 'progress').toList();

      case 3:
        return tasks.where((task) => task.status == 'done').toList();

      default:
        return tasks;
    }
  }

  static List<TaskEntity> getTodayTasks(List<TaskEntity> tasks) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    return tasks.where((task) {
      if (task.startDate == null || task.endDate == null) {
        return false;
      }

      final start = DateTime(
        task.startDate!.year,
        task.startDate!.month,
        task.startDate!.day,
      );

      final end = DateTime(
        task.endDate!.year,
        task.endDate!.month,
        task.endDate!.day,
      );

      return !today.isBefore(start) && !today.isAfter(end);
    }).toList();
  }

  static List<TaskEntity> getEarlierTasks(List<TaskEntity> tasks) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    return tasks.where((task) {
      if (task.endDate == null) {
        return false;
      }

      final end = DateTime(
        task.endDate!.year,
        task.endDate!.month,
        task.endDate!.day,
      );

      return today.isAfter(end);
    }).toList();
  }

  static bool hasTasks(
    List<TaskEntity> todayTasks,
    List<TaskEntity> earlierTasks,
  ) {
    return todayTasks.isNotEmpty || earlierTasks.isNotEmpty;
  }
}
