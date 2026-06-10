import 'package:techyspot_todo/features/home/domain/repository/home_repository.dart';

import '../entites/task_entity.dart';

class UpdateTaskUseCase {
  final HomeRepository _repository;

  UpdateTaskUseCase(this._repository);

  Future<void> call(TaskEntity task) {
    return _repository.updateTask(task);
  }
}
