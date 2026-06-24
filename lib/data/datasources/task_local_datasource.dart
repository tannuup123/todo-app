import 'package:hive/hive.dart';
import '../../../domain/entities/task.dart';

abstract class TaskLocalDataSource {
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

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  static const String _boxName = 'tasksBox';
  late final Box<Task> _tasksBox;

  TaskLocalDataSourceImpl() {
    _tasksBox = Hive.box<Task>(_boxName);
  }

  @override
  Future<List<Task>> getTasks() async {
    return _tasksBox.values.toList();
  }

  @override
  Future<Task> getTask(String id) async {
    final task = _tasksBox.get(id);
    if (task == null) {
      throw Exception('Task not found with id: $id');
    }
    return task;
  }

  @override
  Future<void> addTask(Task task) async {
    await _tasksBox.put(task.id, task);
  }

  @override
  Future<void> updateTask(Task task) async {
    await _tasksBox.put(task.id, task);
  }

  @override
  Future<void> deleteTask(String id) async {
    await _tasksBox.delete(id);
  }

  @override
  Future<List<Task>> searchTasks(String query) async {
    if (query.isEmpty) {
      return await getTasks();
    }
    final lowerQuery = query.toLowerCase();
    return _tasksBox.values.where((task) {
      return task.title.toLowerCase().contains(lowerQuery) ||
          (task.description != null &&
              task.description!.toLowerCase().contains(lowerQuery));
    }).toList();
  }

  @override
  Future<List<Task>> filterTasksByPriority(Priority priority) async {
    return _tasksBox.values.where((task) => task.priority == priority).toList();
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    return _tasksBox.values.where((task) => task.isCompleted).toList();
  }

  @override
  Future<List<Task>> getPendingTasks() async {
    return _tasksBox.values.where((task) => !task.isCompleted).toList();
  }
}