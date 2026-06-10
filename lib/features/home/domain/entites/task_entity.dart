import 'package:techyspot_todo/features/home/data/models/task_model.dart';

class TaskEntity {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? createdAt;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.startDate,
    this.endDate,
    this.createdAt,
  });

  TaskModel toModel() {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      status: status,
      startDate: startDate,
      endDate: endDate,
      createdAt: createdAt,
    );
  }
}