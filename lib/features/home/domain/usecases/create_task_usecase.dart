import 'package:techyspot_todo/features/home/domain/repository/home_repository.dart';

import '../entites/task_entity.dart';

class CreateTaskUseCase {
  final HomeRepository _repository;

  CreateTaskUseCase(this._repository);

  Future<void> call(TaskEntity task) {
    return _repository.createTask(task);
  }
}
