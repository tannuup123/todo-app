import '../../domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<Task> getTask(String id);
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<List<Task>> searchTasks(String query);
  Future<List<Task>> filterTasksByPriority(Priority priority);
  Future<List<Task>> getCompletedTasks();
  Future<List<Task>> getPendingTasks();
}