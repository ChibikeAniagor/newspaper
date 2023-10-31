import 'package:flutter/material.dart';
import 'package:newspaper/Homepage2.dart';
import 'package:newspaper/homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: NewsPage());
  }
}
