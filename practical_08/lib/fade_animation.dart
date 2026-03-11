import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget { // TODO: implement StatefulWidget shortcut - stf, implement StateLess shortcut - stl
  const FadeAnimation({super.key});

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    // TODO: implement initState shortcut - init
    super.initState();

    // animation controller for 2 second
    _controller = AnimationController(
      vsync: this, // only work this animation in app working/opening time
      duration: const Duration(seconds: 2)
    );

    //tween from 0 (invisible) to 1 (fully visible)
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // start animation automatically
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose shortcut - dis
    _controller.dispose(); // clean up controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Animation Example')),
      body: Center(
        child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Hello Flutter',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            )
        )
      ),
    );
  }
}
