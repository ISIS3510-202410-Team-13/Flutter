import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';

class UniScheduleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UniScheduleAppBar({
    super.key,
    required this.color,
    required this.title,
  });

  final Color color;
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(StyleConstants.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.transparent,
      elevation: 0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: color,
        ),
      ),
      leading: IconButton(
        icon: SvgPicture.asset(
            AssetConstants.icBars,
            width: StyleConstants.iconWidth,
            height: StyleConstants.iconHeight,
            color: color,
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
            color: color,
          ),
          onPressed: () {
            context.push(RouteConstants.notifications);
          },
        ),
      ],
    );
  }
}