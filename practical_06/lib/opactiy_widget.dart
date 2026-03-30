import 'package:flutter/material.dart';

void main() {
  runApp(OpactiyWidget());
}

class OpactiyWidget extends StatelessWidget {
  const OpactiyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Opacity Example')),
        body: Center(
          child: Opacity(
            opacity: 0.5, // 50% transparent
            child: Container(
              width: 200,
              height: 200,
              color: Colors.red,
              child: const Center(
                child: Text(
                  'Half Transparent',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
