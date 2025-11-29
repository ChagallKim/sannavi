// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:sannavi/screens/park_list/park_list_screen.dart'; // 기존 import 유지

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TSX: const [selectedPark, setSelectedPark] = useState<string | null>(null);
  String? _selectedPark;

  // TSX: userInfo 객체
  final Map<String, dynamic> _userInfo = {
    'name': "김등산",
    'level': "초급",
    'age': 28,
    'fitness': "보통",
    'totalHikes': 12,
    'achievements': 5,
  };

  // TSX: recommendedCourse 객체
  final Map<String, dynamic> _recommendedCourse = {
    'name': "비룡폭포 코스",
    'difficulty': "초급",
    'reason': "나이 28세, 체력 보통, 탐방 12회 고려",
    'distance': "3.2km",
    'duration': "2시간",
    'elevation': "250m",
  };

  // TSX: courses 배열
  final List<Map<String, dynamic>> _courses = [
    {
      'id': 1,
      'name': "울산바위 코스",
      'difficulty': "중급",
      'distance': "4.6km",
      'duration': "3시간",
      'elevation': "550m",
      'description': "장엄한 바위산의 절경",
    },
    {
      'id': 2,
      'name': "비룡폭포 코스",
      'difficulty': "초급",
      'distance': "3.2km",
      'duration': "2시간",
      'elevation': "250m",
      'description': "아름다운 폭포와 계곡",
    },
    {
      'id': 3,
      'name': "대청봉 코스",
      'difficulty': "상급",
      'distance': "12.8km",
      'duration': "8시간",
      'elevation': "1,200m",
      'description': "설악산 최고봉 정복",
    },
    {
      'id': 4,
      'name': "토왕성폭포 코스",
      'difficulty': "초급",
      'distance': "2.8km",
      'duration': "1.5시간",
      'elevation': "180m",
      'description': "편안한 산책 코스",
    },
    {
      'id': 5,
      'name': "금강굴 코스",
      'difficulty': "중급",
      'distance': "6.5km",
      'duration': "4시간",
      'elevation': "450m",
      'description': "역사적 명소 탐방",
    },
  ];

  // TSX: getDifficultyColor 함수
  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "초급":
        return const Color(0xFF10B981); // emerald-500
      case "중급":
        return const Color(0xFFEAB308); // yellow-500
      case "상급":
        return const Color(0xFFEF4444); // red-500
      default:
        return const Color(0xFF6B7280); // gray-500
    }
  }

  // 공원 선택 화면으로 이동 (TSX의 showParkList 로직 대체)
  Future<void> _openParkList() async {
    // ParkListScreen이 구현되어 있다고 가정하고 네비게이션 처리
    // 실제 구현시 ParkListScreen에서 Navigator.pop(context, "설악산 국립공원") 등으로 값을 넘겨줘야 함
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ParkListScreen()),
    );

    // 데모용 로직: 실제로는 result를 사용하거나, TSX 로직처럼 특정 ID일 때 설정
    // 여기서는 ParkListScreen이 닫힐 때 임의로 설정을 하거나 반환값을 사용한다고 가정
    if (result != null && result is String) {
      setState(() {
        _selectedPark = result;
      });
    } else if (result == 1) {
      // TSX 로직: parkId === 1 일때
      setState(() {
        _selectedPark = "설악산 국립공원";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TSX: flex flex-col h-full bg-gradient-to-b from-emerald-50 to-white
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFECFDF5), Colors.white], // emerald-50 to white
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildUserInfoCard(),
                    const SizedBox(height: 16),
                    if (_selectedPark == null) ...[
                      _buildRecommendedParks(),
                      const SizedBox(height: 16),
                      _buildAllParksButton(),
                      const SizedBox(height: 16),
                      _buildPointsCard(),
                    ] else ...[
                      _buildRecommendedCourseCard(),
                      const SizedBox(height: 16),
                      _buildCourseList(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Sub-widgets corresponding to TSX structure ---

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 60, bottom: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF059669), // emerald-600
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "ParkMate",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _selectedPark ?? "안전하고 즐거운 국립공원 탐방",
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFFD1FAE5).withOpacity(0.9), // emerald-100
                ),
              ),
            ],
          ),
          if (_selectedPark != null)
            TextButton(
              onPressed: () => setState(() => _selectedPark = null),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("공원 변경", style: TextStyle(fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981), // emerald-500
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userInfo['name'],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _buildBadge(_userInfo['level'], const Color(0xFFD1FAE5), const Color(0xFF047857)),
                    Text("${_userInfo['age']}세", style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                    Text("체력 ${_userInfo['fitness']}", style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                    Text("등산 ${_userInfo['totalHikes']}회", style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFEAB308), size: 20),
              const SizedBox(width: 4),
              Text("${_userInfo['achievements']}", style: const TextStyle(color: Color(0xFF374151))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedParks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: const [
              Icon(Icons.star, size: 20, color: Color(0xFFEAB308)),
              SizedBox(width: 8),
              Text("오늘의 추천 공원", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildParkCard(
          "설악산 국립공원",
          "날씨가 좋아요",
          "https://images.unsplash.com/photo-1690379985006-d8aa5ec497e0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxrb3JlYW4lMjBtb3VudGFpbiUyMG5hdGlvbmFsJTIwcGFya3xlbnwxfHx8fDE3NjIzNjI4MDF8MA&ixlib=rb-4.1.0&q=80&w=1080",
        ),
        const SizedBox(height: 12),
        _buildParkCard(
          "북한산 국립공원",
          "가까운 거리",
          "https://images.unsplash.com/photo-1690379985006-d8aa5ec497e0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxrb3JlYW4lMjBtb3VudGFpbiUyMG5hdGlvbmFsJTIwcGFya3xlbnwxfHx8fDE3NjIzNjI4MDF8MA&ixlib=rb-4.1.0&q=80&w=1080",
        ),
      ],
    );
  }

  Widget _buildParkCard(String name, String desc, String imageUrl) {
    return InkWell(
      onTap: () {
        // 데모용: 설악산을 누르면 선택됨
        if (name == "설악산 국립공원") {
          setState(() => _selectedPark = name);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 96,
              height: 96,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                        const SizedBox(height: 4),
                        Text(desc, style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                      ],
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllParksButton() {
    return GestureDetector(
      onTap: _openParkList,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)], // emerald-500 to 600
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: const Color(0xFF10B981).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.location_on, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("전체 공원 목록", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 2),
                    Text("모든 국립공원 둘러보기", style: TextStyle(color: const Color(0xFFD1FAE5).withOpacity(0.9), fontSize: 12)),
                  ],
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFACC15), Color(0xFFF97316)], // yellow-400 to orange-500
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color(0xFFFACC15).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.monetization_on, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("내 포인트", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text("1,250", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Text("점", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text("사용하기", style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedCourseCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF10B981), Color(0xFF0D9488)], // emerald-500 to teal-600
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color(0xFF10B981).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.emoji_events, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("당신을 위한 추천 코스", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 8),
                        _buildBadge(_recommendedCourse['difficulty'], _getDifficultyColor(_recommendedCourse['difficulty']), Colors.white),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_recommendedCourse['name'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(_recommendedCourse['reason'], style: TextStyle(color: const Color(0xFFECFDF5).withOpacity(0.9), fontSize: 12)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildIconText(Icons.hiking, _recommendedCourse['distance'], Colors.white.withOpacity(0.9)),
                        const SizedBox(width: 16),
                        _buildIconText(Icons.access_time, _recommendedCourse['duration'], Colors.white.withOpacity(0.9)),
                        const SizedBox(width: 16),
                        _buildIconText(Icons.show_chart, _recommendedCourse['elevation'], Colors.white.withOpacity(0.9)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF059669),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("이 코스 시작하기", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: const [
              Icon(Icons.hiking, size: 20, color: Color(0xFF059669)),
              SizedBox(width: 8),
              Text("설악산 등산로", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _courses.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final course = _courses[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(course['name'], style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                                const SizedBox(width: 8),
                                _buildBadge(course['difficulty'], _getDifficultyColor(course['difficulty']), Colors.white),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(course['description'], style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildIconText(Icons.hiking, course['distance'], const Color(0xFF4B5563)),
                      const SizedBox(width: 16),
                      _buildIconText(Icons.access_time, course['duration'], const Color(0xFF4B5563)),
                      const SizedBox(width: 16),
                      _buildIconText(Icons.show_chart, course['elevation'], const Color(0xFF4B5563)),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // --- Helper Widgets ---

  Widget _buildBadge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontSize: 10, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }
}