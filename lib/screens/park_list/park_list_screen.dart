// lib/screens/park_list/park_list_screen.dart
import 'package:flutter/material.dart';

class ParkListScreen extends StatelessWidget {
  const ParkListScreen({super.key});

  final List<String> _parks = const [
    '설악산 국립공원',
    '북한산 국립공원',
    '지리산 국립공원',
    '소백산 국립공원',
    '다도해해상 국립공원',
    '한려해상 국립공원',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('탐방 공원 선택'),
      ),
      body: ListView.separated(
        itemCount: _parks.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final park = _parks[index];
          return ListTile(
            title: Text(park),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).pop(park);
            },
          );
        },
      ),
    );
  }
}