import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:techyspot_todo/features/home/data/models/task_model.dart';

class HomeRemoteDatasource {
  final SupabaseClient supabase = Supabase.instance.client;
  HomeRemoteDatasource();

  Future<void> createTask(TaskModel task) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw Exception('User not found');
      }

      final data = task.toJson()..['user_id'] = user.id;

      log('Create Task Payload: $data');

      await supabase.from('tasks').insert(data);

      log('task added successfully');
    } catch (e) {
      log('Create Task Error: $e');
      throw Exception('Failed to create task');
    }
  }

  Future<List<TaskModel>> getTask() async {
    try {
      final response = await supabase
          .from('tasks')
          .select()
          .order('created_at', ascending: false);
      log('tasked fetched successfully');
      return response.map((json) => TaskModel.fromJson(json)).toList();
    } on PostgrestException catch (e) {
      log('Get Tasks Error: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      log('Get Tasks Error: $e');
      throw Exception('Failed to fetch tasks');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await supabase.from('tasks').update(task.toJson()).eq('id', task.id);
      log('tasked updated successfully');
    } on PostgrestException catch (e) {
      log('Update Task Error: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      log('Update Task Error: $e');
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await supabase.from('tasks').delete().eq('id', taskId);
      log('tasked deleted successfully');
    } on PostgrestException catch (e) {
      log('Delete Task Error: ${e.message}');
      throw Exception(e.message);
    } catch (e) {
      log('Delete Task Error: $e');
      throw Exception('Failed to delete task');
    }
  }
}
