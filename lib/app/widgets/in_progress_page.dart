// lib/app/widgets/in_progress_page.dart
import 'package:flutter/material.dart';

class InProgressPage extends StatelessWidget {
  final String title;
  const InProgressPage({required this.title, super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: const Center(
      child: Text(
        '🚧  This page is under construction  🚧',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
