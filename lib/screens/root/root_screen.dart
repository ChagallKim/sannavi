// lib/screens/root/root_screen.dart
import 'package:flutter/material.dart';
import 'package:sannavi/screens/chat/chat_screen.dart'; // 가상의 파일
import 'package:sannavi/screens/community/community_screen.dart';
import 'package:sannavi/screens/encyclopedia/encyclopedia_screen.dart'; // 가상의 파일
import 'package:sannavi/screens/home/home_screen.dart';
import 'package:sannavi/screens/trail/trail_screen.dart'; // 가상의 파일

class ParkMateRoot extends StatefulWidget {
  const ParkMateRoot({super.key});

  @override
  State<ParkMateRoot> createState() => _ParkMateRootState();
}

class _ParkMateRootState extends State<ParkMateRoot> {
  int _selectedIndex = 0;

  // 메인 브랜드 컬러 (HomeScreen의 헤더 색상 참조 - Emerald 600)
  final Color _brandColor = const Color(0xFF059669);
  final Color _inactiveColor = const Color(0xFF9CA3AF); // Gray 400

  // 화면 목록
  static const List<Widget> _screens = [
    HomeScreen(),
    EncyclopediaScreen(),
    TrailScreen(),
    ChatListScreen(),
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
      // SafeArea를 제거하여 자식 스크린의 그라데이션이 상단바까지 차오르도록 함
      // (각 스크린 내부에서 상단 패딩을 처리한다고 가정)
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      // 네비게이션 바에 그림자와 둥근 모서리를 주기 위한 컨테이너
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4), // 위쪽으로 그림자
            ),
          ],
        ),
        // 모서리 깎기 (ClipRRect)
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: _brandColor,
            unselectedItemColor: _inactiveColor,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            elevation: 0, // 기본 그림자 제거 (Container 그림자 사용)
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                activeIcon: Icon(Icons.home_rounded),
                label: '홈',
              ),
              BottomNavigationBarItem(
                // 백과사전 느낌: Lucide의 Book/Menu 느낌
                icon: Icon(Icons.menu_book_rounded),
                activeIcon: Icon(Icons.menu_book_rounded),
                label: '백과',
              ),
              BottomNavigationBarItem(
                // 탐방/등산로 느낌: MapPin or Mountain -> Hiking
                icon: Icon(Icons.hiking_rounded),
                activeIcon: Icon(Icons.hiking_rounded),
                label: '탐방',
              ),
              BottomNavigationBarItem(
                // 채팅
                icon: Icon(Icons.chat_bubble_outline_rounded),
                activeIcon: Icon(Icons.chat_bubble_rounded),
                label: '채팅',
              ),
              BottomNavigationBarItem(
                // 커뮤니티: Lucide Users 느낌
                icon: Icon(Icons.groups_outlined),
                activeIcon: Icon(Icons.groups_rounded),
                label: '커뮤니티',
              ),
            ],
          ),
        ),
      ),
    );
  }
}