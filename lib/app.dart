// lib/app.dart
import 'package:flutter/material.dart';
import 'package:sannavi/screens/root/root_screen.dart';

class ParkMateApp extends StatelessWidget {
  const ParkMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParkMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const ParkMateRoot(),
    );
  }
}