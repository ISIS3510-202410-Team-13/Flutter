import 'package:flutter/material.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/chat/chat_service.dart';

class ChatBottomBar extends StatefulWidget {
  const ChatBottomBar({
    super.key,
    required this.otherUserId,
  });

  final String otherUserId;

  @override
  State<ChatBottomBar> createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {

  final _messageController = TextEditingController();
  bool hasText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: ColorConstants.gullGrey,
            width: 2,
          ),
        ),
      ),
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.add, color: ColorConstants.gullGrey, size: 28),
          const SizedBox(width: 4),
          const Icon(Icons.camera_alt, color: ColorConstants.gullGrey, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.desertStorm,
                border: Border.all(
                  color: ColorConstants.gullGrey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.only(left: 16, right: 4),
              child: TextField(
                controller: _messageController,
                textAlignVertical: TextAlignVertical.center,
                clipBehavior: Clip.antiAlias,
                maxLength: 1000,
                buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                onChanged: (value) {
                  setState(() {
                    hasText = value.isNotEmpty;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: ColorConstants.seaGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.emoji_emotions, color: ColorConstants.gullGrey, size: 28),
                ),
                style: const TextStyle(
                  color: ColorConstants.seaGrey,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: Icon(
              Icons.send,
              color: hasText ? ColorConstants.limerick : ColorConstants.gullGrey,
              size: 28
            ),
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                print(_messageController.text);
                ChatService().sendMessage(_messageController.text, widget.otherUserId)
                  .then((value) => value ? _messageController.clear() : null);
              }
            },
          ),
        ],
      ),
    );
  }
}