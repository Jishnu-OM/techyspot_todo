import 'package:techyspot_todo/features/home/domain/entites/task_entity.dart';

class HomeState {
  final bool isLoading;
  final String? errorMessage;
  final List<TaskEntity> task;
  final String? user;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.task = const [],
    this.user,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<TaskEntity>? task,
    String? user,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      task: task ?? this.task,
      user: user ?? this.user,
    );
  }
}
