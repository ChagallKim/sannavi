// lib/screens/root/root_screen.dart
import 'package:flutter/material.dart';
import 'package:sannavi/screens/chat/chat_screen.dart';
import 'package:sannavi/screens/community/community_screen.dart';
import 'package:sannavi/screens/encyclopedia/encyclopedia_screen.dart';
import 'package:sannavi/screens/home/home_screen.dart';
import 'package:sannavi/screens/trail/trail_screen.dart';

/// 하단 탭 네비게이션과 각 화면을 연결하는 루트 위젯
class ParkMateRoot extends StatefulWidget {
  const ParkMateRoot({super.key});

  @override
  State<ParkMateRoot> createState() => _ParkMateRootState();
}

class _ParkMateRootState extends State<ParkMateRoot> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    EncyclopediaScreen(),
    TrailScreen(),
    ChatScreen(),
    CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: '백과',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route_outlined),
            label: '탐방',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: '커뮤니티',
          ),
        ],
      ),
    );
  }
}