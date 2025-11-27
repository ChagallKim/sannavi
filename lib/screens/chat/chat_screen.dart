import 'package:flutter/material.dart';

// ---------------------------------------------------------
// 1. 데이터 모델 정의 (기존 로직 유지)
// ---------------------------------------------------------

enum ChatCategory { accident, facility, emergency, general }
enum ChatStatus { open, closed }

class ChatMessage {
  final bool fromUser;
  final String text;
  final String time;

  ChatMessage({required this.fromUser, required this.text, required this.time});
}

class ChatRoom {
  final String id;
  final String title;
  final ChatCategory category;
  final ChatStatus status;
  final List<ChatMessage> messages;

  ChatRoom({
    required this.id,
    required this.title,
    required this.category,
    required this.status,
    required this.messages,
  });

  String get subtitle => messages.isNotEmpty ? messages.last.text : '';
  String get lastTime => messages.isNotEmpty ? messages.last.time : '';
}

// ---------------------------------------------------------
// 2. 더미 데이터 (기존 로직 유지)
// ---------------------------------------------------------

final List<ChatMessage> _accidentMessages = [
  ChatMessage(fromUser: false, text: '국립공원 산악안전센터입니다. 신고가 접수되었습니다. 정확한 상황을 설명해주실 수 있나요?', time: '09:10'),
  ChatMessage(fromUser: true, text: '백운대 내려가는 길인데 발목을 심하게 접질렸어요.', time: '09:12'),
  ChatMessage(fromUser: false, text: '현재 정확한 위치 파악을 위해 GPS 좌표를 보내주실 수 있나요?', time: '09:12'),
  ChatMessage(fromUser: true, text: '현재 위치 좌표 전송했습니다. 발목 부상으로 이동이 불가능해요.', time: '09:15'),
];

final List<ChatMessage> _facilityMessages = [
  ChatMessage(fromUser: true, text: '북한산성 입구 쪽 화장실 물이 안내려가요.', time: '어제'),
  ChatMessage(fromUser: false, text: '불편을 드려 죄송합니다. 정확히 어느 쪽 화장실인가요?', time: '어제'),
  ChatMessage(fromUser: true, text: '주차장 바로 옆에 있는 큰 화장실이요.', time: '어제'),
  ChatMessage(fromUser: false, text: '네, 접수되었습니다. 담당자가 곧 현장으로 이동해 조치하겠습니다.', time: '어제'),
];

final List<ChatMessage> _closedMessages = [
  ChatMessage(fromUser: true, text: '둘레길 3구간에 멧돼지가 나타났어요!', time: '2일 전'),
  ChatMessage(fromUser: false, text: '현재 순찰대가 해당 구역으로 이동 중입니다. 안전한 곳으로 대피해주세요.', time: '2일 전'),
  ChatMessage(fromUser: true, text: '사람들이랑 같이 큰길로 내려왔습니다.', time: '2일 전'),
  ChatMessage(fromUser: false, text: '안전하게 하산하셨다니 다행입니다. 신고 감사합니다. 상황 종료하겠습니다.', time: '2일 전'),
];

final List<ChatRoom> _dummyChatRooms = [
  ChatRoom(
    id: '1',
    title: '🚨 [긴급] 구조 요청 (북한산 백운대)',
    category: ChatCategory.accident,
    status: ChatStatus.open,
    messages: _accidentMessages,
  ),
  ChatRoom(
    id: '2',
    title: '화장실 시설 고장 신고',
    category: ChatCategory.facility,
    status: ChatStatus.open,
    messages: _facilityMessages,
  ),
  ChatRoom(
    id: '3',
    title: '멧돼지 출몰 신고',
    category: ChatCategory.emergency,
    status: ChatStatus.closed,
    messages: _closedMessages,
  ),
];

// ---------------------------------------------------------
// 3. 채팅 목록 화면 (Theme 적용)
// ---------------------------------------------------------

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activeAccidents = _dummyChatRooms
        .where((c) => c.category == ChatCategory.accident && c.status == ChatStatus.open)
        .toList();

    final otherChats = _dummyChatRooms
        .where((c) => !(c.category == ChatCategory.accident && c.status == ChatStatus.open))
        .toList();

    return Scaffold(
      // 배경 그라데이션 (Home/Community와 동일한 패턴)
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFECFEFF), Colors.white], // Cyan-50 to White
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. 긴급 사고 영역
                    if (activeAccidents.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 8),
                        child: Row(
                          children: const [
                            Icon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 20),
                            SizedBox(width: 6),
                            Text('진행 중인 긴급 신고', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFEF4444))),
                          ],
                        ),
                      ),
                      ...activeAccidents.map((chat) => _buildActiveAccidentCard(context, chat)),
                      const SizedBox(height: 24),
                    ],

                    // 2. 일반 문의 목록
                    Padding(
                      padding: const EdgeInsets.only(left: 4, bottom: 12),
                      child: Row(
                        children: const [
                          Icon(Icons.history, color: Color(0xFF0F766E), size: 20), // Teal-700
                          SizedBox(width: 6),
                          Text('문의 내역', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF111827))),
                        ],
                      ),
                    ),
                    if (otherChats.isEmpty)
                      _buildEmptyState()
                    else
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: otherChats.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) => _buildChatCard(context, otherChats[index]),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.edit_outlined),
        label: const Text('새 문의하기'),
        backgroundColor: const Color(0xFF0D9488), // Teal-600
        elevation: 4,
      ),
    );
  }

  // 커스텀 헤더 (Home/Community 스타일)
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 60, bottom: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D9488), Color(0xFF0891B2)], // Teal-600 to Cyan-600
        ),
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
                "관리소 1:1 문의",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                "안전하고 쾌적한 탐방을 도와드립니다",
                style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.support_agent, color: Colors.white, size: 28),
          )
        ],
      ),
    );
  }

  Widget _buildActiveAccidentCard(BuildContext context, ChatRoom chat) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context, chat),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2), // Red-50
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFECACA)), // Red-200
          boxShadow: [BoxShadow(color: const Color(0xFFEF4444).withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFFEF4444), borderRadius: BorderRadius.circular(8)),
                        child: const Text('처리 중', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          chat.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF991B1B), fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              chat.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF4B5563), fontSize: 14),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(chat.lastTime, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatCard(BuildContext context, ChatRoom chat) {
    final isClosed = chat.status == ChatStatus.closed;

    return GestureDetector(
      onTap: () => _navigateToDetail(context, chat),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            // 아이콘 아바타
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isClosed ? const Color(0xFFF3F4F6) : const Color(0xFFCCFBF1), // Gray-100 or Teal-100
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                _getCategoryIcon(chat.category),
                color: isClosed ? const Color(0xFF9CA3AF) : const Color(0xFF0F766E), // Gray-400 or Teal-700
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                chat.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: isClosed ? const Color(0xFF6B7280) : const Color(0xFF111827),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isClosed) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0xFFE5E7EB), borderRadius: BorderRadius.circular(6)),
                                child: const Text('종료', style: TextStyle(fontSize: 10, color: Color(0xFF4B5563), fontWeight: FontWeight.w600)),
                              ),
                            ]
                          ],
                        ),
                      ),
                      Text(chat.lastTime, style: const TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Icon(Icons.chat_bubble_outline, size: 48, color: Colors.grey[300]),
          const SizedBox(height: 16),
          const Text('문의 내역이 없습니다.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  void _navigateToDetail(BuildContext context, ChatRoom chat) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(chatRoom: chat)));
  }

  IconData _getCategoryIcon(ChatCategory category) {
    switch (category) {
      case ChatCategory.accident: return Icons.medical_services;
      case ChatCategory.facility: return Icons.build;
      case ChatCategory.emergency: return Icons.sos;
      case ChatCategory.general: return Icons.help_outline;
    }
  }
}

// ---------------------------------------------------------
// 4. 채팅 상세 화면 (Theme 적용)
// ---------------------------------------------------------

class ChatDetailScreen extends StatefulWidget {
  final ChatRoom chatRoom;
  const ChatDetailScreen({super.key, required this.chatRoom});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  late List<ChatMessage> _messages;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.chatRoom.messages);
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(fromUser: true, text: text, time: _formatTime()));
    });
    _controller.clear();

    if (widget.chatRoom.status == ChatStatus.open) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          setState(() {
            _messages.add(ChatMessage(
              fromUser: false,
              text: '네, 내용 확인했습니다. 담당자가 확인 후 답변 드리겠습니다.',
              time: _formatTime(),
            ));
          });
        }
      });
    }
  }

  String _formatTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isAccident = widget.chatRoom.category == ChatCategory.accident;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Gray-100
      body: Column(
        children: [
          // Detail Header (축소된 형태)
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: MediaQuery.of(context).padding.top + 10, bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isAccident
                    ? [const Color(0xFFDC2626), const Color(0xFFB91C1C)] // Red-600 to 700
                    : [const Color(0xFF0D9488), const Color(0xFF0891B2)], // Teal-600 to Cyan-600
              ),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatRoom.title,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isAccident ? '국립공원 특수산악구조대' : '국립공원 관리소 직원',
                        style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                if (isAccident)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.phone, color: Colors.white, size: 20),
                  ),
              ],
            ),
          ),

          // 긴급 상황 알림 바
          if (isAccident && widget.chatRoom.status == ChatStatus.open)
            Container(
              width: double.infinity,
              color: const Color(0xFFFEF2F2), // Red-50
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                children: const [
                  Icon(Icons.warning_amber_rounded, size: 18, color: Color(0xFFEF4444)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '구조대가 출동 준비 중입니다. 위치를 이동하지 마세요.',
                      style: TextStyle(color: Color(0xFFB91C1C), fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

          // 메시지 리스트
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _ChatMessageBubble(message: _messages[index], isAccident: isAccident),
            ),
          ),

          // 입력창
          if (widget.chatRoom.status == ChatStatus.open)
            _buildMessageInput(isAccident)
          else
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: const [
                  Icon(Icons.check_circle_outline, size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('상담이 종료되었습니다.', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(bool isAccident) {
    final primaryColor = isAccident ? const Color(0xFFEF4444) : const Color(0xFF0D9488);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: MediaQuery.of(context).padding.bottom + 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(24)),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Color(0xFF6B7280)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: '메시지를 입력하세요...',
                hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                filled: true,
                fillColor: const Color(0xFFF3F4F6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                isDense: true,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isAccident;

  const _ChatMessageBubble({required this.message, required this.isAccident});

  @override
  Widget build(BuildContext context) {
    final isMe = message.fromUser;
    final primaryColor = isAccident ? const Color(0xFFEF4444) : const Color(0xFF0D9488); // Red-500 or Teal-600

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: isAccident ? const Color(0xFFFEE2E2) : const Color(0xFFCCFBF1),
                  child: Icon(Icons.support_agent, size: 18, color: primaryColor),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isMe
                        ? primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isMe ? 20 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 20),
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1)),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 15,
                      color: isMe ? Colors.white : const Color(0xFF374151),
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 4,
                left: isMe ? 0 : 40,
                right: isMe ? 4 : 0
            ),
            child: Text(
              message.time,
              style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatListScreen()
  ));
}