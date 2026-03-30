import 'package:flutter/material.dart';

void main() {
  runApp(ScaffoldWidget());
}

class ScaffoldWidget extends StatefulWidget {
  const ScaffoldWidget({super.key});

  @override
  State<ScaffoldWidget> createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Scaffold Example')),
        body: Center(child: Text('Page ${_selectedIndex + 1}')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('FAB Clicked!')));
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Menu', style: TextStyle(color: Colors.white)),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
