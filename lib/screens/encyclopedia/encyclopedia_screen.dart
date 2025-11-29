// lib/screens/encyclopedia/encyclopedia_screen.dart
import 'package:flutter/material.dart';

class EncyclopediaScreen extends StatelessWidget {
  const EncyclopediaScreen({super.key});

  final List<Map<String, String>> _items = const [
    {
      'name': '산양',
      'type': '야생동물',
      'desc': '설악산, 오대산 등에 서식하는 멸종위기 야생동물 Ⅰ급.',
      'image': 'assets/images/goral.jpg', // 대체 이미지
    },
    {
      'name': '구상나무',
      'type': '식물',
      'desc': '한라산과 지리산에 주로 분포하는 고산 침엽수.',
      'image': 'assets/images/korean_fir.jpg', // 대체 이미지
    },
    {
      'name': '반달가슴곰',
      'type': '야생동물',
      'desc': '지리산의 대표적인 깃대종으로, 천연기념물이자 멸종위기 야생동물 Ⅰ급.',
      'image': 'assets/images/asiatic_black_bear.jpg', // 대체 이미지
    },
    {
      'name': '수달',
      'type': '야생동물',
      'desc': '하천 생태계의 최상위 포식자로, 건강한 수생태계의 지표종.',
      'image': 'assets/images/otter.jpg', // 대체 이미지
    },
    {
      'name': '솔부엉이',
      'type': '야생동물',
      'desc': '여름철새로 산지나 평지의 숲에서 번식하는 맹금류.',
      'image': 'assets/images/brown_hawk-owl.jpg',
    },
    {
      'name': '금강초롱꽃',
      'type': '식물',
      'desc': '한국 특산종으로 높은 산의 숲속 그늘에서 자라는 아름다운 꽃.',
      'image': 'assets/images/diamond_bluebell.jpg',
    },
  ];

  Color _getTypeColor(String type) {
    switch (type) {
      case '야생동물':
        return const Color(0xFFF97316); // orange-500
      case '식물':
        return const Color(0xFF10B981); // emerald-500
      default:
        return const Color(0xFF6B7280); // gray-500
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Cyan-50 to White (청량한 느낌의 배경)
            colors: [Color(0xFFECFEFF), Colors.white],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildGridList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 60, bottom: 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          // Cyan-600 to Blue-600 (지식/백과사전 느낌)
          colors: [Color(0xFF0891B2), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "국립공원 백과",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "자연의 친구들을 만나보세요",
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFFCFFAFE).withOpacity(0.9), // cyan-100
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: '종 이름, 공원명을 검색해보세요',
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF0891B2)), // cyan-600
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildGridList() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 24),
        itemCount: _items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75, // 비율 조정으로 카드 공간 확보
        ),
        itemBuilder: (context, index) {
          final item = _items[index];
          return _buildEncyclopediaCard(item);
        },
      ),
    );
  }

  Widget _buildEncyclopediaCard(Map<String, String> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // 상세 화면 이동 로직
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지 영역
              Expanded(
                flex: 5,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      item['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                    // 타입 뱃지 (이미지 위에 오버레이)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _getTypeColor(item['type']!),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item['type']!,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF374151),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 텍스트 내용 영역
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['desc']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}