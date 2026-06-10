class TaskUiModel {
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String status;
  final bool completed;

  const TaskUiModel({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.completed,
  });
}