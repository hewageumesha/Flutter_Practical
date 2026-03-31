import 'package:flutter/material.dart';

void main() {
  runApp(AppbarWidget());
}

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AppBar Example'),
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
        body: Center(child: Text('AppBar Example')),
      ),
    );
  }
}
