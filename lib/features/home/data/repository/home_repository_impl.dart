import 'package:techyspot_todo/features/home/data/datasources/home_remote_datasource.dart';
import 'package:techyspot_todo/features/home/domain/entites/task_entity.dart';
import 'package:techyspot_todo/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDatasource remoteDs;
  HomeRepositoryImpl(this.remoteDs);

  @override
  Future<void> createTask(TaskEntity task) async {
    return await remoteDs.createTask(task.toModel());
  }

  @override
  Future<void> deleteTask(String taskId) async {
    return await remoteDs.deleteTask(taskId);
  }

  @override
  Future<List<TaskEntity>> getTask() async {
    final models = await remoteDs.getTask();
    final entities = models.map((m) => m.toEntity()).toList();
    return entities;
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    return await remoteDs.updateTask(task.toModel());
  }
}
