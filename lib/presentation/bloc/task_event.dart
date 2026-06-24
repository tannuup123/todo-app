part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String id;

  const DeleteTask({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchTasks extends TaskEvent {
  final String query;

  const SearchTasks({required this.query});

  @override
  List<Object> get props => [query];
}

class FilterTasksByPriority extends TaskEvent {
  final Priority priority;

  const FilterTasksByPriority(this.priority);

  @override
  List<Object> get props => [priority];
}

class GetCompletedTasks extends TaskEvent {}

class GetPendingTasks extends TaskEvent {}

class ToggleTaskCompletion extends TaskEvent {
  final String id;

  const ToggleTaskCompletion({required this.id});

  @override
  List<Object> get props => [id];
}