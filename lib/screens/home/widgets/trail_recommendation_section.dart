// lib/screens/home/widgets/trail_recommendation_section.dart
import 'package:flutter/material.dart';
import 'package:sannavi/widgets/info_chip.dart';

class TrailRecommendationSection extends StatelessWidget {
  const TrailRecommendationSection({super.key});

  // 실제 앱에서는 외부에서 데이터를 주입받습니다.
  final List<Map<String, String>> _recommendedCourses = const [
    {
      'name': '설악산 공룡능선 코스',
      'park': '설악산 국립공원',
      'difficulty': '상',
      'time': '4시간 30분',
      'elevation': '900m+'
    },
    {
      'name': '북한산 백운대 코스',
      'park': '북한산 국립공원',
      'difficulty': '중',
      'time': '3시간 20분',
      'elevation': '700m+'
    },
    {
      'name': '지리산 노고단 코스',
      'park': '지리산 국립공원',
      'difficulty': '하',
      'time': '2시간 40분',
      'elevation': '450m+'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '오늘의 추천 탐방 코스',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Column(
          children: _recommendedCourses.map((course) {
            return Card(
              elevation: 1,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () { /* TODO: 코스 상세 화면으로 이동 */ },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course['park']!,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InfoChip(
                            icon: Icons.leaderboard_outlined,
                            label: '난이도 ${course['difficulty']}',
                          ),
                          InfoChip(
                            icon: Icons.schedule_outlined,
                            label: course['time']!,
                          ),
                          InfoChip(
                            icon: Icons.stacked_line_chart_outlined,
                            label: course['elevation']!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}