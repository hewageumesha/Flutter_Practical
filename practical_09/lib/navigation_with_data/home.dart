import 'package:flutter/material.dart';
import 'package:practical_09/navigation_with_data/detail_screen.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<String> items = ['Apple', 'Banana', 'Orange'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
            child: ListTile(
              title: Text(items[index]),
              tileColor: Colors.grey[300],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(item: items[index]),
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
