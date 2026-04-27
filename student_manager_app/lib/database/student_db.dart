import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:student_manager_app/model/student.dart';

Database? _db;
final _store = intMapStoreFactory.store('students');

Future<Database> getDatabase() async {
  if (_db != null) return _db!;

  if (kIsWeb) {
    _db = await databaseFactoryWeb.openDatabase('student_database.db');
  } else {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'student_database.db');
    _db = await databaseFactoryIo.openDatabase(path);
  }

  return _db!;
}

Future<void> insertStudent(Student student) async {
  final db = await getDatabase();
  await _store.add(db, student.toMap());
}

Future<List<Student>> retrieveStudents() async {
  final db = await getDatabase();
  final records = await _store.find(db);
  return records
      .map((r) => Student.fromMap(r.value, id: r.key))
      .toList();
}

Future<void> updateStudent(Student student) async {
  final db = await getDatabase();
  await _store.record(student.id!).update(db, student.toMap());
}

Future<void> deleteStudent(int id) async {
  final db = await getDatabase();
  await _store.record(id).delete(db);
}