import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New screen'),
      ),
      body: const Center(
        child: Text('Hello'),
      ),
    );
  }
}
