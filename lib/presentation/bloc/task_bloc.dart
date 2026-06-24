import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/repositories/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository _taskRepository;

  TaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<SearchTasks>(_onSearchTasks);
    on<FilterTasksByPriority>(_onFilterTasksByPriority);
    on<GetCompletedTasks>(_onGetCompletedTasks);
    on<GetPendingTasks>(_onGetPendingTasks);
    on<ToggleTaskCompletion>(_onToggleTaskCompletion);
  }

  Future<void> _onLoadTasks(
      LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await _taskRepository.getTasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }

  Future<void> _onAddTask(
      AddTask event, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.addTask(event.task);
      // Reload tasks to reflect the addition
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTask(
      UpdateTask event, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.updateTask(event.task);
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTask(
      DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.deleteTask(event.id);
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }

  Future<void> _onSearchTasks(
      SearchTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks =
          await _taskRepository.searchTasks(event.query);
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }

  Future<void> _onFilterTasksByPriority(
      FilterTasksByPriority event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks =
          await _taskRepository.filterTasksByPriority(event.priority);
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }

  Future<void> _onGetCompletedTasks(
      GetCompletedTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks =
          await _taskRepository.getCompletedTasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }

  Future<void> _onGetPendingTasks(
      GetPendingTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks =
          await _taskRepository.getPendingTasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }

  Future<void> _onToggleTaskCompletion(
      ToggleTaskCompletion event, Emitter<TaskState> emit) async {
    try {
      final task = await _taskRepository.getTask(event.id);
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
        updatedAt: DateTime.now(),
      );
      await _taskRepository.updateTask(updatedTask);
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(message: e.toString()));
    }
  }
}