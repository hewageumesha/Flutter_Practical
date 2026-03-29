import 'package:flutter/material.dart';
import 'package:practical_06/container_widget.dart';
import 'package:practical_06/stateful_widget.dart';

void main() {
  runApp(const MyApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ContainerWidget());
  }
}
