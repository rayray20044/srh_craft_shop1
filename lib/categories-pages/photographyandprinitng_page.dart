import 'package:flutter/material.dart';

class PhotographyAndPrintingPage extends StatelessWidget {
  const PhotographyAndPrintingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('photography '),
      ),
      body: const Center(
        child: Text('This is the Art Supplies Page'),
      ),
    );
  }
}