// lib/main.dart
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// 🔥 로그인 성공 시 이동할 화면(하단바 포함)
import 'package:sannavi/screens/root/root_screen.dart';

// 로그인 UI가 있는 웰컴 페이지
import 'welcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  runApp(const ParkMateApp());
}

class ParkMateApp extends StatelessWidget {
  const ParkMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 실행 직후 로딩
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 🔥 로그인 되어 있음 → ParkMateRoot 실행 (하단바 포함)
        if (snapshot.hasData) {
          return const ParkMateRoot();
        }

        // 🔥 로그인 안되어 있음 → 웰컴 페이지
        return const WelcomePage();
      },
    );
  }
}
