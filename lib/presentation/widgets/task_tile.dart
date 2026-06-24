import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/bloc/task_bloc.dart';
import 'package:todo/presentation/widgets/task_form_dialog.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        // Find the current task from state to ensure we have latest data
        Task currentTask = task;
        if (state is TaskLoaded) {
          final matchedTask =
              state.tasks.firstWhere((t) => t.id == task.id, orElse: () => task);
          currentTask = matchedTask;
        }
        return ListTile(
          leading: Checkbox(
            value: currentTask.isCompleted,
            onChanged: (_) {
              context
                  .read<TaskBloc>()
                  .add(ToggleTaskCompletion(id: currentTask.id));
            },
          ),
          title: Text(
            currentTask.title,
            style: TextStyle(
              decoration:
                  currentTask.isCompleted ? TextDecoration.lineThrough : null,
              color: currentTask.isCompleted ? Colors.grey : null,
            ),
          ),
          subtitle: currentTask.description != null &&
                  currentTask.description!.isNotEmpty
              ? Text(
                  currentTask.description!,
                  style: TextStyle(
                    color: currentTask.isCompleted ? Colors.grey : null,
                  ),
                )
              : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editTask(context),
                tooltip: 'Edit',
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteTask(context),
                tooltip: 'Delete',
              ),
            ],
          ),
          onTap: () {
            context
                .read<TaskBloc>()
                .add(ToggleTaskCompletion(id: currentTask.id));
          },
        );
      },
    );
  }

  void _editTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => TaskFormDialog(
        onSave: (updatedTask) {
          context.read<TaskBloc>().add(UpdateTask(task: updatedTask));
        },
        initialTask: task,
      ),
    );
  }

  void _deleteTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<TaskBloc>().add(DeleteTask(id: task.id));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${task.title} deleted')),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}