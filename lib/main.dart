import 'package:flutter/material.dart';
import 'package:safeconnex/front_end_code/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Connex',
      home: HomePage()
    );
  }
}