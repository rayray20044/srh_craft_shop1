import 'package:flutter/material.dart';

class ArtAndSuppliesPage extends StatelessWidget {
  const ArtAndSuppliesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Supplies'),
      ),
      body: const Center(
        child: Text('This is the Art Supplies Page'),
      ),
    );
  }
}
