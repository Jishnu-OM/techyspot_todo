import 'package:techyspot_todo/features/home/domain/repository/home_repository.dart';

class DeleteTaskUseCase {
  final HomeRepository _repository;

  DeleteTaskUseCase(this._repository);

  Future<void> call(String taskId) {
    return _repository.deleteTask(taskId);
  }
}
