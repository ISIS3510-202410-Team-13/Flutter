import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unischedule/constants/constants.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String name;
  final String profilePicture;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.name,
    required this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          if (!isMe) buildProfilePicture(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: ColorConstants.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: (isMe) ? TextAlign.end : TextAlign.start,
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                      color: ColorConstants.black,
                      fontSize: 16,
                    ),
                    textAlign: (isMe) ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          if (isMe) buildProfilePicture()
        ],
      ),
    );
  }

  Widget buildProfilePicture() {
    return CachedNetworkImage(
      imageUrl: profilePicture,
      fadeInDuration: const Duration(milliseconds: 100),
      fadeOutDuration: const Duration(milliseconds: 100),
      filterQuality: FilterQuality.none,
      maxHeightDiskCache: 100,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 26.5,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => const CircleAvatar(
        radius: 26.5,
        backgroundColor: ColorConstants.gullGrey,
      ),
      errorWidget: (context, url, error) => const CircleAvatar(
        radius: 26.5,
        backgroundColor: ColorConstants.white,
        child: Icon(Icons.person, color: ColorConstants.gullGrey),
      ),
    );
  }
}