import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';

class ChatTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String otherUserName;
  final String otherUserPhotoUrl;

  const ChatTopBar({
    super.key,
    required this.otherUserName,
    required this.otherUserPhotoUrl,
  });

  @override
  Size get preferredSize => const Size.fromHeight(StyleConstants.appBarHeight + 10);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(20),
        ),
        side: BorderSide(color: ColorConstants.gullGrey, width: 2, strokeAlign: BorderSide.strokeAlignOutside),
      ),
      elevation: 0,
      //leadingWidth: 0,
      title: Row(
        children: [
          CachedNetworkImage(
            imageUrl: otherUserPhotoUrl,
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
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  otherUserName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: ColorConstants.seaGrey,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Online',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ColorConstants.seaGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/arrow-left.svg', // TODO use AssetConstants
          width: StyleConstants.iconWidth,
          height: StyleConstants.iconHeight,
          color: ColorConstants.gullGrey,
        ),
        onPressed: () {
          context.pop();
        },
      ),
      titleSpacing: 10,
      actions: [
        Icon(Icons.push_pin, color: ColorConstants.gullGrey, size: 36),
        const SizedBox(width: 10),
        Icon(Icons.calendar_month, color: ColorConstants.gullGrey, size: 36),
        const SizedBox(width: 20),
      ],
    );
  }
}