import 'package:flutter/material.dart';

class PaperAndCardPage extends StatelessWidget {
  const PaperAndCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('paper and card'),
      ),
      body: const Center(
        child: Text('This is the Art Supplies Page'),
      ),
    );
  }
}