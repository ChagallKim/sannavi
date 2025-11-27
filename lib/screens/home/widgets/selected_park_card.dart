// lib/screens/home/widgets/selected_park_card.dart
import 'package:flutter/material.dart';

class SelectedParkCard extends StatelessWidget {
  final String? selectedPark;
  final VoidCallback onTap;

  const SelectedParkCard({
    super.key,
    required this.selectedPark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.park_outlined, color: Colors.green[700]),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedPark ?? '탐방할 공원을 선택해보세요',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      selectedPark == null
                          ? '국립공원 목록에서 코스를 찾아볼 수 있어요'
                          : '탐방 코스 추천과 실시간 정보를 확인해보세요',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}