import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/bloc/task_bloc.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.flag),
            title: const Text('Low Priority'),
            onTap: () {
              Navigator.pop(context);
              context
                  .read<TaskBloc>()
                  .add(FilterTasksByPriority(Priority.low));
            },
          ),
          ListTile(
            leading: const Icon(Icons.flag),
            title: const Text('Medium Priority'),
            onTap: () {
              Navigator.pop(context);
              context
                  .read<TaskBloc>()
                  .add(FilterTasksByPriority(Priority.medium));
            },
          ),
          ListTile(
            leading: const Icon(Icons.flag),
            title: const Text('High Priority'),
            onTap: () {
              Navigator.pop(context);
              context
                  .read<TaskBloc>()
                  .add(FilterTasksByPriority(Priority.high));
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('Completed Tasks'),
            onTap: () {
              Navigator.pop(context);
              context
                  .read<TaskBloc>()
                  .add(GetCompletedTasks());
            },
          ),
          ListTile(
            leading: const Icon(Icons.pending_actions),
            title: const Text('Pending Tasks'),
            onTap: () {
              Navigator.pop(context);
              context
                  .read<TaskBloc>()
                  .add(GetPendingTasks());
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('All Tasks'),
            onTap: () {
              Navigator.pop(context);
              context.read<TaskBloc>().add(LoadTasks());
            },
          ),
        ],
      ),
    );
  }
}