import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/colors/color_constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'widgets/chat_bubble.dart';
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

    final user = ref.watch(authenticationStatusProvider);
    final otherUser = ref.watch(getFriendProvider(friendId: widget.otherUserId));

    if (user == null || otherUser == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final photoPlaceholder = 'https://storage.googleapis.com/unischedule-profile_pictures/user_${Random().nextInt(24)}.png';
    if(user.photoURL == null) user.updatePhotoURL(photoPlaceholder); // TODO currently handling null photoURL with a placeholder

    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: ChatTopBar(
        otherUserName: otherUser.name,
        otherUserPhotoUrl: otherUser.profilePicture,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: "Message very large to test how chat works! 💪💪💪 #$index",
                  isMe: index % 2 == 0,
                  name: (index % 2 == 0) ? user.displayName! : otherUser.name,
                  profilePicture: (index % 2 == 0) ? user.photoURL! : otherUser.profilePicture,
                );
              },
            ),
          ),
          ChatBottomBar(),
        ],
      ),
    );
  }
}