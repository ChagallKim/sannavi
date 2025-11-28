// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:sannavi/screens/home/widgets/header_card.dart';
import 'package:sannavi/screens/home/widgets/selected_park_card.dart';
import 'package:sannavi/screens/home/widgets/today_stats_card.dart';
import 'package:sannavi/screens/home/widgets/trail_recommendation_section.dart';
import 'package:sannavi/screens/park_list/park_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedPark;

  // 실제 앱에서는 이 데이터들을 ViewModel이나 State Management를 통해 관리합니다.
  final Map<String, dynamic> _userInfo = {
    'name': '김등산',
    'level': '탐방 마스터',
    'location': '서울시 강남구',
  };

  final List<Map<String, String>> _todayStats = [
    {'label': '오늘 거리', 'value': '8.2 km'},
    {'label': '소요 시간', 'value': '3시간 10분'},
    {'label': '소모 칼로리', 'value': '680 kcal'},
  ];

  Future<void> _openParkList() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const ParkListScreen()),
    );

    if (result != null) {
      setState(() {
        _selectedPark = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFECFDF5), Colors.white],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            HeaderCard(userInfo: _userInfo),
            const SizedBox(height: 16),
            TodayStatsCard(todayStats: _todayStats),
            const SizedBox(height: 16),
            SelectedParkCard(
              selectedPark: _selectedPark,
              onTap: _openParkList,
            ),
            const SizedBox(height: 16),
            const TrailRecommendationSection(),
          ],
        ),
      ),
    );
  }
}