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
}