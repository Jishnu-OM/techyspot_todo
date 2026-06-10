import 'package:techyspot_todo/features/home/domain/entites/task_entity.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? createdAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.startDate,
    this.endDate,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
    };
  }

  TaskEntity toEntity() {
    return TaskEntity(
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
