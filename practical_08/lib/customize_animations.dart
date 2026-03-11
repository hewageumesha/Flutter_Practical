import 'package:flutter/material.dart';

class CustomizeAnimations extends StatefulWidget {
  const CustomizeAnimations({super.key});

  @override
  State<CustomizeAnimations> createState() => _CustomizeAnimationsState();
}

class _CustomizeAnimationsState extends State<CustomizeAnimations> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _customizeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2)
    );

    _customizeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.bounceIn
      )
    );

    _controller.repeat(reverse: true);
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _customizeAnimation,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.red,
              child: Center(
                child: Text(
                  'Customize Animation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.none
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_controller.isAnimating) {
                    _controller.stop();
                  } else {
                    _controller.repeat(reverse: true);
                  }
                });
              },
            child: Text(_controller.isAnimating ? 'Stop' : 'Start'),
          )
        ],
      ),
    );
  }
}
