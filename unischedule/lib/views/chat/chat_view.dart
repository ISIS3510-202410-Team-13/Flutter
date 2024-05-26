import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/colors/color_constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/services/chat/chat_service.dart';
import 'widgets/message_list.dart';
import 'widgets/chat_bottom_bar.dart';
import 'widgets/chat_top_bar.dart';

class ChatView extends ConsumerStatefulWidget {
  final String otherUserId;

  const ChatView({
    super.key,
    required this.otherUserId,
  });

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  @override
  Widget build(BuildContext context) {

    final connectivity = ref.watch(connectivityStatusProvider);

    final user = ref.watch(authenticationStatusProvider);
    final otherUser = ref.watch(getFriendProvider(friendId: widget.otherUserId));

    final _messageController = TextEditingController(text: ChatService().getLastTyped(widget.otherUserId));

    if (user == null || otherUser == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: ChatTopBar(
        otherUserName: otherUser.name,
        otherUserPhotoUrl: otherUser.profilePicture,
      ),
      body: Column(
        children: [
          if (connectivity != ConnectivityStatus.isConnected)
            Container(
              color: ColorConstants.red,
              padding: const EdgeInsets.all(8),
              child: const Row(
                children: [
                  Icon(Icons.error, color: ColorConstants.white),
                  SizedBox(width: 8),
                  Text(
                    'No internet connection',
                    style: TextStyle(color: ColorConstants.white),
                  ),
                ],
              ),
            ),
          Expanded(
            child: MessageList(receiverId: widget.otherUserId, userId: user.uid),
          ),
          ChatBottomBar(otherUserId: otherUser.id, messageController: _messageController),
        ],
      ),
    );
  }
}