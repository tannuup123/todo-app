import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/bloc/task_bloc.dart';

class TaskSearchDelegate extends SearchDelegate<String?> {
  final TaskBloc bloc;

  TaskSearchDelegate({required this.bloc});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    bloc.add(SearchTasks(query: query));
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is TaskLoaded) {
          final tasks = state.tasks;
          if (tasks.isEmpty) {
            return const Center(
              child: Text('No tasks found'),
            );
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) {
                    bloc.add(ToggleTaskCompletion(id: task.id));
                  },
                ),
                title: Text(task.title),
                subtitle: task.description != null &&
                        task.description!.isNotEmpty
                    ? Text(task.description!)
                    : null,
                trailing: Text(
                  _formatDate(task.dueDate),
                  style: TextStyle(
                    color: task.isCompleted ? Colors.grey : null,
                  ),
                ),
                onTap: () {
                  close(context, task.id);
                },
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      bloc.add(LoadTasks());
    } else {
      bloc.add(SearchTasks(query: query));
    }
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is TaskLoaded) {
          final tasks = state.tasks;
          if (tasks.isEmpty) {
            return const Center(
              child: Text('No tasks found'),
            );
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                leading: const Icon(Icons.edit),
                title: Text(task.title),
                onTap: () {
                  query = task.title;
                  showResults(context);
                },
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.month}/${date.day}/${date.year}';
  }
}