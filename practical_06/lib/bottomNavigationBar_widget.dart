import 'package:flutter/material.dart';

void main() {
  runApp(BottomnavigationbarWidget());
}

class BottomnavigationbarWidget extends StatelessWidget {
  const BottomnavigationbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BottomNavExample());
  }
}

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});

  @override
  State<BottomNavExample> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _selectedIndex = 0;

  // pages to display for each tab
  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Home Screen', style: TextStyle(fontSize: 24))),
    Center(child: Text('Settings Srenn', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Navigation Example')),
      body: _pages[_selectedIndex],
      bottomNavigationBar:  BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
