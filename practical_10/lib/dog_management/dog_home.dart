import 'package:flutter/material.dart';
import 'package:practical_10/dog_management/database/dog_db.dart';
import 'package:practical_10/dog_management/model/dog.dart';

void main() {
  runApp(const DogHome());
}

class DogHome extends StatefulWidget {
  const DogHome({super.key});

  @override
  State<DogHome> createState() => _DogHomeState();
}

class _DogHomeState extends State<DogHome> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  late Future<List<Dog>> _dogsFuture;

  @override
  void initState() {
    super.initState();
    _refreshDogs();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _refreshDogs() {
    setState(() {
      _dogsFuture = retrieveDogs();
    });
  }

  // CREATE
  void _handleSave() async {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text) ?? 0;

    if (name.isEmpty || age <= 0) return;

    await insertDog(Dog(name: name, age: age));

    if (!mounted) return;

    _nameController.clear();
    _ageController.clear();
    _refreshDogs();
  }

  // UPDATE
  void _handleUpdate(int id) async {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text) ?? 0;

    if (name.isEmpty || age <= 0) return;

    await updateDog(Dog(id: id, name: name, age: age));

    if (!mounted) return;

    _refreshDogs();
  }

  // DELETE
  void _handleDelete(int id) async {
    await deleteDog(id);
    if (!mounted) return;
    _refreshDogs();
  }

  void _showDogDialog(Dog? dog) {
    if (dog != null) {
      _nameController.text = dog.name;
      _ageController.text = dog.age.toString();
    } else {
      _nameController.clear();
      _ageController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(dog != null ? 'Edit Dog' : 'Add Dog'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // close dialog first

                if (dog != null) {
                  _handleUpdate(dog.id!);
                } else {
                  _handleSave();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Dog Management')),
        body: FutureBuilder<List<Dog>>(
          future: _dogsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No dogs found'));
            }

            final dogs = snapshot.data!;

            return ListView.builder(
              itemCount: dogs.length,
              itemBuilder: (context, index) {
                final dog = dogs[index];

                return ListTile(
                  leading: const Icon(Icons.pets),
                  title: Text(dog.name),
                  subtitle: Text('Age: ${dog.age}'),
                  onTap: () => _showDogDialog(dog),
                  onLongPress: () => _handleDelete(dog.id!),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showDogDialog(null),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}