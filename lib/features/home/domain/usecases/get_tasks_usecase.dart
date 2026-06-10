import 'package:techyspot_todo/features/home/domain/repository/home_repository.dart';

import '../entites/task_entity.dart';

class GetTasksUseCase {
  final HomeRepository _repository;

  GetTasksUseCase(this._repository);

  Future<List<TaskEntity>> call() {
    return _repository.getTask();
  }
}
