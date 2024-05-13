import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';

class NotificationsAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const NotificationsAppBar({super.key});

  @override
  ConsumerState<NotificationsAppBar> createState() => _NotificationsAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(StyleConstants.appBarHeight);
}

class _NotificationsAppBarState extends ConsumerState<NotificationsAppBar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg', // TODO use AssetConstants
            width: 21, // TODO use StyleConstants
            height: 24,  // TODO use StyleConstants
            color: ColorConstants.black
        ),
        onPressed: () {
          context.pop();
        },
      ),
      title: const Text(
        'Notifications', // TODO use StringConstants
        style: TextStyle( // TODO use text theme
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: ColorConstants.black,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}