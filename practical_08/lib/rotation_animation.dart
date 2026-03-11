import 'package:flutter/material.dart';

class RotationAnimation extends StatefulWidget {
  const RotationAnimation({super.key});

  @override
  State<RotationAnimation> createState() => _RotationAnimationState();
}

class _RotationAnimationState extends State<RotationAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2)
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut
      )
    );

    _controller.repeat(); // if you want it to run indefinitely
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _rotationAnimation,
        child: Container(
          width: 200,
          height: 200,
          color: Colors.orange,
          child: Center(
            child: Text(
              'Rotation Animation',
              style:
              TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),
            ),
          ),
        )
      ),
    );
  }
}
