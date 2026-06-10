import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:techyspot_todo/features/home/data/datasources/home_remote_datasource.dart';
import 'package:techyspot_todo/features/home/data/repository/home_repository_impl.dart';
import 'package:techyspot_todo/features/home/domain/entites/task_entity.dart';
import 'package:techyspot_todo/features/home/domain/usecases/create_task_usecase.dart';
import 'package:techyspot_todo/features/home/domain/usecases/delete_task_usecase.dart';
import 'package:techyspot_todo/features/home/domain/usecases/get_tasks_usecase.dart';
import 'package:techyspot_todo/features/home/domain/usecases/update_task_usecase.dart';
import 'package:techyspot_todo/features/home/presentation/providers/home_state.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final datasource = HomeRemoteDatasource();
  final repository = HomeRepositoryImpl(datasource);
  final createTaskUseCase = CreateTaskUseCase(repository);
  final deleteTaskUseCase = DeleteTaskUseCase(repository);
  final updateTaskUseCase = UpdateTaskUseCase(repository);
  final getTaskUseCase = GetTasksUseCase(repository);

  return HomeNotifier(
    createTaskUseCase,
    deleteTaskUseCase,
    updateTaskUseCase,
    getTaskUseCase,
  );
});

class HomeNotifier extends StateNotifier<HomeState> {
  final CreateTaskUseCase _createTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final GetTasksUseCase _getTaskUseCase;

  HomeNotifier(
    this._createTaskUseCase,
    this._deleteTaskUseCase,
    this._updateTaskUseCase,
    this._getTaskUseCase,
  ) : super(const HomeState());

  Future<void> getTasks() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final tasks = await _getTaskUseCase();
      final user = Supabase.instance.client.auth.currentUser;

      state = state.copyWith(isLoading: false, task: tasks, user: user?.email,);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> createTask(TaskEntity task) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _createTaskUseCase(task);

      final tasks = await _getTaskUseCase();

      state = state.copyWith(isLoading: false, task: tasks);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _updateTaskUseCase(task);

      final tasks = await _getTaskUseCase();

      state = state.copyWith(isLoading: false, task: tasks);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteTask(String taskId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _deleteTaskUseCase(taskId);

      final tasks = await _getTaskUseCase();

      state = state.copyWith(isLoading: false, task: tasks);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
  
  Future<void> updateTaskStatus(
  TaskEntity task,
) async {
  try {
    final updatedTask = TaskEntity(
      id: task.id,
      title: task.title,
      description: task.description,
      startDate: task.startDate,
      endDate: task.endDate,
      createdAt: task.createdAt,

      status: task.status.toLowerCase() == 'done'
          ? 'todo'
          : 'done',
    );

    await _updateTaskUseCase(
      updatedTask,
    );

    await getTasks();
  } catch (e) {
    state = state.copyWith(
      errorMessage: e.toString(),
    );
  }
}
}
