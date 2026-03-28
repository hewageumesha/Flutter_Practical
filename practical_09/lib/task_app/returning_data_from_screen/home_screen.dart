import 'package:flutter/material.dart';
import 'package:practical_09/task_app/returning_data_from_screen/selection_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => const SelectionScreen(),
              ),
            );

            if (result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You selected: $result')),
              );
            }
          }, 
          child: const Text('Pick an option'),
        ),
      ),
    );
  }
}
