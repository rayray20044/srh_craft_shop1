import 'package:flutter/material.dart';

class CuttingToolsPage extends StatelessWidget {
  const CuttingToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cutting Tools'),
      ),
      body: const Center(
        child: Text('This is the Cutting Tools Page'),
      ),
    );
  }
}
