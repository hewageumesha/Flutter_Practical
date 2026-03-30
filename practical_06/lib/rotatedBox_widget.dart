import 'package:flutter/material.dart';

void main() {
  runApp(RotatedboxWidget());
}

class RotatedboxWidget extends StatelessWidget {
  const RotatedboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('RotatedBox Example')),
        body: Center(
          child: RotatedBox(
            quarterTurns: 1, // rotates 90 degree clockwise
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.green,
              child: const Text(
                'Rotated Text',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
