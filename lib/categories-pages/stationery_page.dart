import 'package:flutter/material.dart';

class StationeryPage extends StatelessWidget {
  const StationeryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('stationary page'),
      ),
      body: const Center(
        child: Text('This is the Cutting Tools Page'),
      ),
    );
  }
}
