import 'package:flutter/material.dart';
import 'package:practical_09/to_do_screen/detail_screen.dart';

class Todo {
  final String title;
  final String description;

  const Todo({required this.title, required this.description});
}

class ToDoScreen extends StatelessWidget {
  final List<Todo> todos;

  const ToDoScreen({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ListTile(
              tileColor: Colors.grey[300],
              title: Text(todos[index].title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => DetailScreen(todo: todos[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
