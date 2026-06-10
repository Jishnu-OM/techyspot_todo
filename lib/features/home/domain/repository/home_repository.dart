import 'package:techyspot_todo/features/home/domain/entites/task_entity.dart';

abstract class HomeRepository {
  Future<void> createTask(TaskEntity task);
  Future<List<TaskEntity>> getTask();
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String taskId);
}
