import 'package:flutter/material.dart';

void main() {
  runApp(RishtextWidget());
}

class RishtextWidget extends StatelessWidget {
  const RishtextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('RishText Example')),
        body: Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 24, color: Colors.black),
              children: [
                TextSpan(
                  text: 'Bold Text',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'Normal Text'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
