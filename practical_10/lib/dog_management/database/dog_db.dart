import 'package:practical_10/dog_management/model/dog.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Initialize and open the database, creating the necessary table if it doesn't exist
Future<Database> initializaDB() async {
  String path = join(await getDatabasesPath(), 'dogs_database.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
      );
    },
    version: 1,
  );
}

// To insert a new dog into the database
Future<void> insertDog(Dog dog) async {
  final db = await initializaDB();
  await db.insert(
    'dogs',
    dog.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// To retrieve all dogs from the database
Future<List<Dog>> retrieveDogs() async {
  final db = await initializaDB();
  final List<Map<String, dynamic>> queryResult = await db.query('dogs');
  return queryResult.map((e) => Dog.fromMap(e)).toList();
}

// To update an existing dog's information
Future<void> updateDog(Dog dog) async {
  final db = await initializaDB();
  await db.update('dogs', dog.toMap(), where: 'id=?', whereArgs: [dog.id]);
}

// To delete a dog from the database:
Future<void> deleteDog(int id) async {
  final db = await initializaDB();
  await db.delete('dogs', where: 'id=?', whereArgs: [id]);
}
