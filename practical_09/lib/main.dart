import 'package:flutter/material.dart';
import 'package:practical_09/activity_four.dart';
import 'package:practical_09/activity_one.dart';
import 'package:practical_09/activity_two.dart';
import 'package:practical_09/activity_three.dart';
import 'package:practical_09/navigation_with_named_route.dart/main_screen.dart';
import 'package:practical_09/navigation_with_named_route.dart/profile_screen.dart';
import 'package:practical_09/navigation_with_named_route.dart/settings_screen.dart';
import 'package:practical_09/registration/user_registration_form.dart';
import 'package:practical_09/navigation_with_data/home.dart';
import 'package:practical_09/tabs_in_flutter/my_home_page.dart';
import 'package:practical_09/to_do_screen/to_do_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      // initialRoute: '/',

      // routes: {
      //   '/': (context) => MainScreen(),
      //   '/settings': (context) => SettingsScreen(),
      //   '/profile': (context) => ProfileScreen(name: 'Nethmi Umesha'),
      // },

      // title: 'Flutter Tabs Demo',
      // theme: ThemeData(primarySwatch: Colors.blue),
      // home: MyHomePage()

      title: 'Passing Data',
      theme: ThemeData(primaryColor: Colors.blue),
      home: ToDoScreen(
        todos: List.generate(
          5, 
          (i) => Todo(
            title: 'Todo $i',
            description: 'Description of what needs to be done for Todo $i',
          ),
        )
      ),
    );
  }
}