import 'package:flutter/material.dart';

class ActivityTwo extends StatefulWidget {
  const ActivityTwo({super.key});

  @override
  State<ActivityTwo> createState() => _ActivityTwoState();
}

class _ActivityTwoState extends State<ActivityTwo> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity Two')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: .center,
              spacing: 20,
              children: [
                // username TextFormField
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Username!';
                    }
                    return null;
                  },
                ),

                // password TextFormField
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your Password!';
                    }
                    return null;
                  },
                ),

                // elevatedButton to validate the form
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form Submitted Successfully!'),
                        ),
                      ); 
                    }
                  },
                  child: Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}