import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule/constants/constants.dart';

class UniScheduleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UniScheduleAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(StyleConstants.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.transparent,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
            AssetConstants.icBars,
            width: StyleConstants.iconWidth,
            height: StyleConstants.iconHeight,
            color: ColorConstants.white,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            AssetConstants.icBell,
            width: StyleConstants.iconWidth,
            height: StyleConstants.iconHeight,
            color: ColorConstants.white,
          ),
          onPressed: () {
            // TODO implement logic for notifications
          },
        ),
      ],
    );
  }
}