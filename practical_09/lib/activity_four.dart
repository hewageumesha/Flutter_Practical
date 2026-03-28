import 'package:flutter/material.dart';

class ActivityFour extends StatefulWidget {
  const ActivityFour({super.key});

  @override
  State<ActivityFour> createState() => _ActivityFourState();
}

class _ActivityFourState extends State<ActivityFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity Four')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            print('Container Tapped!');
          },
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Center(
              child: Text('Tap me!'),
            ),
          ),
        ),
      ),
    );
  }
}