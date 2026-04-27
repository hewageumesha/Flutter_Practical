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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2196F3)),
        useMaterial3: false, 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2196F3),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
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
    'Computer Science',
    'Mathematics',
    'Physics',
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

    if (name.isEmpty || age <= 0 || course.isEmpty) {
      ScaffoldMessenger.of(_safeContext).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields correctly.')),
      );
      return;
    }

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

    if (name.isEmpty || age <= 0 || course.isEmpty) {
      ScaffoldMessenger.of(_safeContext).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields correctly.')),
      );
      return;
    }

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
            child: const Text(
              'YES',
              style: TextStyle(color: Color(0xFF2196F3)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(_safeContext),
            child: const Text(
              'NO',
              style: TextStyle(color: Color(0xFF2196F3)),
            ),
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
            titlePadding: EdgeInsets.zero,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF2196F3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Text(
                student != null ? 'Edit Student' : 'Add Student',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCourse,
                  decoration: const InputDecoration(
                    labelText: 'Course',
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                  ),
                  items: courses.map((course) {
                    return DropdownMenuItem<String>(
                      value: course,
                      child: Text(course, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setStateDialog(() {
                      selectedCourse = value;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Color(0xFF2196F3)),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  if (student != null) {
                    handleUpdate(student.id!);
                  } else {
                    handleSave();
                  }
                },
                child: const Text(
                  'SAVE',
                  style: TextStyle(color: Color(0xFF2196F3)),
                ),
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
      appBar: AppBar(
        title: const Text(
          'Student Manager',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder<List<Student>>(
        future: studentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No students found.\nTap + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          final students = snapshot.data!;
          return ListView.separated(
            itemCount: students.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                title: Text(
                  student.name,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  '${student.age}, ${student.course}',
                  style: const TextStyle(color: Colors.black54),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined,
                          color: Colors.blueGrey),
                      tooltip: 'Edit',
                      onPressed: () => showStudentDialog(student),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.redAccent),
                      tooltip: 'Delete',
                      onPressed: () => confirmDelete(student.id!),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showStudentDialog(null),
        backgroundColor: const Color(0xFF2196F3),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}