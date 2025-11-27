// lib/app.dart
import 'package:flutter/material.dart';
import 'package:sannavi/screens/root/root_screen.dart';

/// 전체 앱의 루트 위젯. MaterialApp을 정의합니다.
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