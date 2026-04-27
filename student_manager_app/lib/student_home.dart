import 'package:flutter/material.dart';
import 'package:student_manager_app/database/student_db.dart';
import 'package:student_manager_app/model/student.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, 
      home: const StudentHome(),
    );
  }
}

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  late Future<List<Student>> studentFuture;

  final List<String> courses = [
    'Engineering Technology',
    'Bio System Technology',
    'Information and Communication Technology',
  ];

  String? selectedCourse;
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  BuildContext get _safeContext => navigatorKey.currentContext!;

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void loadStudents() {
    setState(() {
      studentFuture = retrieveStudents();
    });
  }

  void handleSave() async {
    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text) ?? 0;
    final course = selectedCourse ?? '';

    if (name.isEmpty || age <= 0 || course.isEmpty) return;

    await insertStudent(Student(name: name, age: age, course: course));
    if (!mounted) return;

    nameController.clear();
    ageController.clear();
    selectedCourse = null;
    loadStudents();

    ScaffoldMessenger.of(_safeContext).showSnackBar(
      const SnackBar(content: Text('Student Added!')),
    );
  }

  void handleUpdate(int id) async {
    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text) ?? 0;
    final course = selectedCourse ?? '';

    if (name.isEmpty || age <= 0 || course.isEmpty) return;

    await updateStudent(Student(id: id, name: name, age: age, course: course));
    if (!mounted) return;

    loadStudents();

    ScaffoldMessenger.of(_safeContext).showSnackBar(
      const SnackBar(content: Text('Student Updated!')),
    );
  }

  void handleDelete(int id) async {
    await deleteStudent(id);
    if (!mounted) return;
    loadStudents();

    ScaffoldMessenger.of(_safeContext).showSnackBar(
      const SnackBar(content: Text('Student Deleted!')),
    );
  }

  void confirmDelete(int id) {
    showDialog(
      context: _safeContext, 
      builder: (_) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this student?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(_safeContext);
              handleDelete(id);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(_safeContext),
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  void showStudentDialog(Student? student) {
    if (student != null) {
      nameController.text = student.name;
      ageController.text = student.age.toString();
      selectedCourse = student.course;
    } else {
      nameController.clear();
      ageController.clear();
      selectedCourse = null;
    }

    showDialog(
      context: _safeContext,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setStateDialog) {
          return AlertDialog(
            title: Text(student != null ? 'Edit Student' : 'Add Student'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedCourse,
                  items: courses.map((course) {
                    return DropdownMenuItem<String>(
                      value: course,
                      child: Text(course),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setStateDialog(() {
                      selectedCourse = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Course',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  if (student != null) {
                    handleUpdate(student.id!);
                  } else {
                    handleSave();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Manager App')),
      body: FutureBuilder<List<Student>>(
        future: studentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No students found!'));
          }

          final students = snapshot.data!;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(student.name),
                subtitle: Text('${student.age}, ${student.course}'),
                onTap: () => showStudentDialog(student),      
                onLongPress: () => confirmDelete(student.id!), 
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showStudentDialog(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}