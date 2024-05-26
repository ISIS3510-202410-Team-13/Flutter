import 'package:flutter/material.dart';
import 'package:unischedule/constants/constants.dart';

class ChatBottomBar extends StatelessWidget {
  const ChatBottomBar({super.key});

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
                textAlignVertical: TextAlignVertical.center,
                clipBehavior: Clip.antiAlias,
                maxLength: 1000,
                buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
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
            icon: const Icon(Icons.send, color: ColorConstants.gullGrey, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}