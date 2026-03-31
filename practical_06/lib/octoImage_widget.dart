import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

void main() {
  runApp(const OctoImageWidget());
}

class OctoImageWidget extends StatelessWidget {
  const OctoImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('OctoImage Example')),
        body: Center(
          child: OctoImage(
            image: const NetworkImage('https://via.placeholder.com/150'),
            placeholderBuilder: OctoPlaceholder.blurHash(
              'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
            ),
            errorBuilder: OctoError.icon(color: Colors.red),
          ),
        ),
      ),
    );
  }
}