import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Task>> getTasks() => localDataSource.getTasks();

  @override
  Future<Task> getTask(String id) => localDataSource.getTask(id);

  @override
  Future<void> addTask(Task task) => localDataSource.addTask(task);

  @override
  Future<void> updateTask(Task task) => localDataSource.updateTask(task);

  @override
  Future<void> deleteTask(String id) => localDataSource.deleteTask(id);

  @override
  Future<List<Task>> searchTasks(String query) =>
      localDataSource.searchTasks(query);

  @override
  Future<List<Task>> filterTasksByPriority(Priority priority) =>
      localDataSource.filterTasksByPriority(priority);

  @override
  Future<List<Task>> getCompletedTasks() =>
      localDataSource.getCompletedTasks();

  @override
  Future<List<Task>> getPendingTasks() =>
      localDataSource.getPendingTasks();
}