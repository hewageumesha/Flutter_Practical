import 'package:flutter/material.dart';
import 'package:practical_08/combine_animations.dart';
import 'package:practical_08/customize_animations.dart';
import 'package:practical_08/rotation_animation.dart';
import 'package:practical_08/fade_animation.dart';
import 'package:practical_08/scaler_animation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CustomizeAnimations());
  }
}

