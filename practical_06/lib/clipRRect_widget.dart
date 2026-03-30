import 'package:flutter/material.dart';

void main() {
  runApp(CliprrectWidget());
}

class CliprrectWidget extends StatelessWidget {
  const CliprrectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ClipRRect Example')),
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://www.vecteezy.com/free-photos/image',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
