// lib/screens/community/community_screen.dart
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  final List<Map<String, dynamic>> _posts = const [
    {'author': '산타는고양이', 'title': '북한산 백운대 오늘 다녀왔어요!', 'content': '생각보다 눈이 많이 녹아서 아이젠은 없어도 괜찮았어요. 대신 바람이 많이 불어서 체감 온도는 낮았어요.', 'likes': 32, 'comments': 5, 'time': '2시간 전'},
    {'author': '지리산덕후', 'title': '지리산 1박 2일 코스 추천 부탁드립니다', 'content': '노고단, 반야봉, 천왕봉 중에서 어디를 넣을지 고민 중이에요. 텐트는 없고 대피소 이용 예정입니다.', 'likes': 18, 'comments': 12, 'time': '5시간 전'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('탐방 커뮤니티'),
        actions: [
          IconButton(
            onPressed: () { /* TODO: 내 글만 보기 / 필터 */ },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { /* TODO: 새 글 작성 화면 */ },
        child: const Icon(Icons.edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: '공원 이름, 코스명, 작성자 검색',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(999)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _posts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) => _PostCard(post: _posts[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Map<String, dynamic> post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () { /* TODO: 게시글 상세 */ },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 14, child: Icon(Icons.person, size: 16)),
                  const SizedBox(width: 8),
                  Text(post['author'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text(post['time'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 8),
              Text(post['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(
                post['content'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.favorite_border, size: 16, color: Colors.red[400]),
                  const SizedBox(width: 4),
                  Text('${post['likes']}', style: const TextStyle(fontSize: 11)),
                  const SizedBox(width: 12),
                  const Icon(Icons.chat_bubble_outline, size: 16),
                  const SizedBox(width: 4),
                  Text('${post['comments']}', style: const TextStyle(fontSize: 11)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}