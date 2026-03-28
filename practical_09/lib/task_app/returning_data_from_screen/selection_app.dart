import 'package:flutter/material.dart';
import 'package:practical_09/task_app/returning_data_from_screen/home_screen.dart';

class SelectionApp extends StatelessWidget {
  const SelectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selection Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
