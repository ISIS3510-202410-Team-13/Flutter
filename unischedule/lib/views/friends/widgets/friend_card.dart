import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/constants/constants.dart';

class FriendCard extends StatelessWidget {
  final FriendModel friend;
  const FriendCard({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
      height: 55,
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(30),
          right: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(2.0),
              child: CachedNetworkImage(
                imageUrl: friend.profilePicture,
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
                  child: Icon(Icons.error, color: ColorConstants.red),
                ),
              )),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              friend.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: ColorConstants.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              child: SvgPicture.asset(
                AssetConstants.icComment,
                width: StyleConstants.iconWidth,
                height: StyleConstants.iconHeight,
                color: ColorConstants.gullGrey,
              ),
              onTap: () {
                context.push(RouteConstants.chat, extra: friend.id);
              }
            ),
          ),
        ],
      ),
    );
  }
}