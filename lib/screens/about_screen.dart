import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  final String title;
  const AboutScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Fashion Store — учебный магазин одежды, созданный на Flutter и Firebase.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}