import 'package:flutter/material.dart';
import 'package:practical_09/task_app/passing_data_to_screen/task_details_screen.dart';

class Task {
  final String title;
  final String description;

  Task({required this.title, required this.description});
}

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = List.generate(
      10,
      (i) => Task(title: 'Task $i', description: 'Details of Task $i'),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailsScreen(task: tasks[index]),
                ),
              );
              if (result != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Returned: $result')));
              }
            },
          );
        },
      ),
    );
  }
}
