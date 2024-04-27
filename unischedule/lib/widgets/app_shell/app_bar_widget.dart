import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/providers/providers.dart';



class UniScheduleAppBar extends ConsumerWidget implements PreferredSizeWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatus = ref.watch(connectivityStatusProvider);
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
        // Add Non-clickable Connectivity Icon
        if (connectivityStatus == ConnectivityStatus.isDisconnected) // Assuming true means online
    Icon(Icons.wifi_off,color: color,size: 28,)
        else
        Icon(Icons.wifi,color: color,size: 28,),
        // Existing Notification Button
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