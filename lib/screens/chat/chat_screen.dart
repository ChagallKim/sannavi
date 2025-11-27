// lib/screens/chat/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:sannavi/models/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(fromUser: false, text: '안녕하세요! 오늘은 어떤 탐방을 계획 중이신가요?', time: '09:12'),
    ChatMessage(fromUser: true, text: '서울 근교에서 3~4시간 정도 코스 추천해줘.', time: '09:13'),
    ChatMessage(fromUser: false, text: '북한산 백운대 코스를 추천드릴게요. 난이도는 중간이고, 왕복 약 3시간 30분 정도 소요돼요.', time: '09:13'),
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(fromUser: true, text: text, time: _formatTime()));
    });
    _controller.clear();

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _messages.add(ChatMessage(fromUser: false, text: '말씀해주신 내용 기반으로 더 자세한 코스를 찾아볼게요!', time: _formatTime()));
      });
    });
  }

  String _formatTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('탐방 AI 상담')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _ChatMessageBubble(message: _messages[index]),
            ),
          ),
          const Divider(height: 1),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          IconButton(
            onPressed: () { /* TODO: 추천 질문 / 프리셋 */ },
            icon: const Icon(Icons.auto_awesome_outlined),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: '탐방 계획, 난이도, 소요 시간 등을 물어보세요',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(999)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

class _ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _ChatMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final align = message.fromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final mainAlign = message.fromUser ? MainAxisAlignment.end : MainAxisAlignment.start;
    final bgColor = message.fromUser ? Colors.green[100] : Colors.grey[100];
    final avatar = message.fromUser
        ? const CircleAvatar(radius: 12, child: Icon(Icons.person, size: 16))
        : const CircleAvatar(radius: 12, child: Icon(Icons.park, size: 16));

    return Column(
      crossAxisAlignment: align,
      children: [
        Row(
          mainAxisAlignment: mainAlign,
          children: [
            if (!message.fromUser) ...[avatar, const SizedBox(width: 8)],
            Flexible(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
                child: Text(message.text),
              ),
            ),
            if (message.fromUser) ...[const SizedBox(width: 8), avatar],
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
          child: Text(message.time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ),
      ],
    );
  }
}