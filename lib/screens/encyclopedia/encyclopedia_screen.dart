// lib/screens/encyclopedia/encyclopedia_screen.dart
import 'package:flutter/material.dart';

class EncyclopediaScreen extends StatelessWidget {
  const EncyclopediaScreen({super.key});

  final List<Map<String, String>> _items = const [
    {'name': '산양', 'type': '야생동물', 'desc': '설악산, 오대산 등에 서식하는 멸종위기 야생동물 Ⅰ급.'},
    {'name': '구상나무', 'type': '식물', 'desc': '한라산과 지리산에 주로 분포하는 고산 침엽수.'},
    {'name': '주흘산 억새', 'type': '식생', 'desc': '가을철 억새 군락지가 아름다운 탐방 명소.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('국립공원 백과'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: '종 이름, 공원명을 검색해보세요',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(999)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(item['name']!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(item['type']!, style: TextStyle(fontSize: 12, color: Colors.green[700])),
                          const SizedBox(height: 4),
                          Text(item['desc']!, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      onTap: () { /* TODO: 상세 설명 화면 */ },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}