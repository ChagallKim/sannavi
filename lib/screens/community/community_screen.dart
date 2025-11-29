// lib/screens/community/community_screen.dart
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  // 내 정보 데이터
  final Map<String, dynamic> _myInfo = const {
    'name': "김등산",
    'level': "초급",
    'age': 28,
    'fitness': "보통",
    'totalHikes': 12,
    'achievements': 5,
    'joinDate': "2024.01",
  };

  // 동료 목록 데이터
  final List<Map<String, dynamic>> _companions = const [
    {'id': 1, 'name': "이산이", 'level': "중급", 'status': "온라인", 'totalHikes': 45},
    {'id': 2, 'name': "박자연", 'level': "초급", 'status': "등산중", 'totalHikes': 8},
    {'id': 3, 'name': "최하이킹", 'level': "상급", 'status': "오프라인", 'totalHikes': 120},
    {'id': 4, 'name': "정산악", 'level': "중급", 'status': "오프라인", 'totalHikes': 67},
  ];

  // 국립공원 리뷰 데이터
  final List<Map<String, dynamic>> _reviews = const [
    {
      'id': 1,
      'userName': "김등산",
      'userLevel': "초급",
      'park': "설악산 국립공원",
      'trail': "비룡폭포 코스",
      'rating': 5,
      'content': "초보자도 무리 없이 즐길 수 있는 코스였어요! 폭포 경치가 정말 아름다웠습니다.",
      'likes': 24,
      'comments': 5,
      'date': "2024.11.05",
      'image': "https://images.unsplash.com/photo-1690379985006-d8aa5ec497e0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxrb3JlYW4lMjBtb3VudGFpbiUyMG5hdGlvbmFsJTIwcGFya3xlbnwxfHx8fDE3NjIzNjI4MDF8MA&ixlib=rb-4.1.0&q=80&w=1080",
    },
    {
      'id': 2,
      'userName': "이산이",
      'userLevel': "중급",
      'park': "북한산 국립공원",
      'trail': "백운대 코스",
      'rating': 4,
      'content': "주말에는 사람이 많지만 정상에서의 전망이 최고입니다!",
      'likes': 18,
      'comments': 3,
      'date': "2024.11.03",
      'image': "https://images.unsplash.com/photo-1690379985006-d8aa5ec497e0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxrb3JlYW4lMjBtb3VudGFpbiUyMG5hdGlvbmFsJTIwcGFya3xlbnwxfHx8fDE3NjIzNjI4MDF8MA&ixlib=rb-4.1.0&q=80&w=1080",
    },
    {
      'id': 3,
      'userName': "최하이킹",
      'userLevel': "상급",
      'park': "설악산 국립공원",
      'trail': "대청봉 코스",
      'rating': 5,
      'content': "체력 소모가 크지만 그만큼 보람찬 코스입니다. 새벽 일출 추천!",
      'likes': 42,
      'comments': 12,
      'date': "2024.10.28",
      'image': "https://images.unsplash.com/photo-1538422314488-83e8e11d298c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxmb3Jlc3QlMjBoaWtpbmclMjB0cmFpbHxlbnwxfHx8fDE3NjIyNTEzMjF8MA&ixlib=rb-4.1.0&q=80&w=1080",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "온라인":
        return const Color(0xFF10B981); // emerald-500
      case "등산중":
        return const Color(0xFF3B82F6); // blue-500
      default:
        return const Color(0xFF9CA3AF); // gray-400
    }
  }

  Color _getLevelColor(String level) {
    switch (level) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFAF5FF), Colors.white], // purple-50 to white
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    _buildMyInfoCard(),
                    const SizedBox(height: 16),
                    _buildCompanionsCard(),
                    const SizedBox(height: 16),
                    _buildReviewsSection(),
                    const SizedBox(height: 24),
                    _buildWriteReviewButton(),
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
          colors: [Color(0xFF9333EA), Color(0xFFDB2777)], // purple-600 to pink-600
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
              "커뮤니티",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "등산 동료와 함께 소통하세요",
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFFF3E8FF).withOpacity(0.9), // purple-100
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.person, size: 20, color: Color(0xFF9333EA)), // purple-600
              SizedBox(width: 8),
              Text(
                "내 정보",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFA855F7), // purple-500
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
                      _myInfo['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _buildBadge(
                          _myInfo['level'],
                          _getLevelColor(_myInfo['level']),
                        ),
                        Text(
                          "${_myInfo['age']}세",
                          style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563)),
                        ),
                        Text(
                          "체력 ${_myInfo['fitness']}",
                          style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      children: [
                        Text("등산 ${_myInfo['totalHikes']}회", style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                        Text("업적 ${_myInfo['achievements']}개", style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                        Text("가입 ${_myInfo['joinDate']}", style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompanionsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.group, size: 20, color: Color(0xFF9333EA)),
                  SizedBox(width: 8),
                  Text(
                    "나의 동료",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA855F7), // purple-500
                  foregroundColor: Colors.white,
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text("동료 추가", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _companions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final companion = _companions[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB), // gray-50
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE5E7EB), // gray-200
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, color: Color(0xFF4B5563)),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  companion['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _buildBadge(
                                  companion['level'],
                                  _getLevelColor(companion['level']),
                                  fontSize: 10,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "등산 ${companion['totalHikes']}회",
                              style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getStatusColor(companion['status']),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          companion['status'],
                          style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563)),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: const [
              Icon(Icons.comment, size: 20, color: Color(0xFF9333EA)),
              SizedBox(width: 8),
              Text(
                "국립공원 리뷰",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _reviews.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final review = _reviews[index];
            return Container(
              padding: const EdgeInsets.all(16),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Review Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFFA855F7), // purple-500
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.person, color: Colors.white, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    review['userName'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  _buildBadge(
                                    review['userLevel'],
                                    _getLevelColor(review['userLevel']),
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                              Text(
                                review['date'],
                                style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: List.generate(5, (starIndex) {
                          return Icon(
                            Icons.star,
                            size: 16,
                            color: starIndex < review['rating']
                                ? const Color(0xFFEAB308) // yellow-500
                                : const Color(0xFFD1D5DB), // gray-300
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Park Info
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Color(0xFF6B7280)),
                      const SizedBox(width: 4),
                      Text(review['park'], style: const TextStyle(fontSize: 12, color: Color(0xFF374151))),
                      const SizedBox(width: 4),
                      const Text("·", style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                      const SizedBox(width: 4),
                      Text(review['trail'], style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Image
                  if (review['image'] != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          review['image'],
                          width: double.infinity,
                          height: 192,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 192,
                              color: Colors.grey[200],
                              child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                            );
                          },
                        ),
                      ),
                    ),
                  // Content
                  Text(
                    review['content'],
                    style: const TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF374151)),
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  const SizedBox(height: 12),
                  // Actions
                  Row(
                    children: [
                      _buildActionButton(Icons.thumb_up_alt_outlined, "${review['likes']}"),
                      const SizedBox(width: 16),
                      _buildActionButton(Icons.comment_outlined, "${review['comments']}"),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildWriteReviewButton() {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFA855F7), Color(0xFFEC4899)], // purple-500 to pink-500
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: const Center(
            child: Text(
              "리뷰 작성하기",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildBadge(String text, Color color, {double fontSize = 12}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String count) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF4B5563)),
          const SizedBox(width: 6),
          Text(
            count,
            style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563)),
          ),
        ],
      ),
    );
  }
}