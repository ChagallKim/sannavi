// lib/models/chat_message.dart
class ChatMessage {
  final bool fromUser;
  final String text;
  final String time;

  ChatMessage({
    required this.fromUser,
    required this.text,
    required this.time,
  });
}