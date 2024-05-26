import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unischedule/constants/colors/color_constants.dart';
import 'package:unischedule/services/chat/chat_service.dart';

import 'chat_bubble.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.receiverId, required this.userId});
  final String userId;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ChatService().getMessages(receiverId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("We're sorry, but we couldn't load the messages. Please check your internet connection."),
            ),
          );
        }

        final messages = snapshot.data?.docs.reversed;
        if (messages == null || messages.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text('No messages yet'),
            ),
          );
        }

        final messagesByDate = <String, List<Map<String, dynamic>>>{};
        for (final message in messages) {
          final messageData = message.data() as Map<String, dynamic>;
          final timestamp = messageData['timestamp'] as Timestamp;
          final date = DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch).toIso8601String().substring(0, 10);
          if (messagesByDate[date] == null) {
            messagesByDate[date] = [];
          }
          messagesByDate[date]?.add(messageData);
        }

        final orderedDates = messagesByDate.keys.toList()..sort();

        return ListView.builder(
          itemCount: messagesByDate.length,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemBuilder: (context, index) {
            final date = orderedDates[index];
            return _buildMessagesByDate(date, messagesByDate[date]!);
          },
        );
      },
    );
  }

  Widget _buildMessagesByDate(String date, List<Map<String, dynamic>> messages) {
    DateFormat df = DateFormat('MMMM dd, yyyy');
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: ColorConstants.gullGrey,
                height: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                df.format(DateTime.parse(date)),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorConstants.gullGrey,
                ),
              ),
            ),
            const Expanded(
              child: Divider(
                color: ColorConstants.gullGrey,
                height: 1,
              ),
            ),
          ],
        ),
        for (final message in messages)
          ChatBubble(
            message: message['message'],
            isMe: message['senderId'] == userId,
            name: message['name'],
            profilePicture: message['profilePicture'],
          ),
      ],
    );
  }
}