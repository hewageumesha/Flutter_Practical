import 'package:flutter/material.dart';

class ActivityOne extends StatefulWidget {
  const ActivityOne({super.key});

  @override
  State<ActivityOne> createState() => _ActivityOneState();
}

class _ActivityOneState extends State<ActivityOne> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity One')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter Your Name',
                  border: UnderlineInputBorder(),
                ),
                controller: _controller1,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter your Email',
                  border: UnderlineInputBorder(),
                ),
                controller: _controller2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your Email!';
                  }
                  return null;
                },
              ),

              // evevatedButton to show the text from the TextField
              ElevatedButton(
                onPressed: () {
                  print('Text from TextField: ${_controller1.text}');
                  print('Text from TextFormField: ${_controller2.text}');
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
