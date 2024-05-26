import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/colors/color_constants.dart';
import 'package:unischedule/providers/providers.dart';
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

    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: ChatTopBar(
        otherUserName: otherUser.name,
        otherUserPhotoUrl: otherUser.profilePicture,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}