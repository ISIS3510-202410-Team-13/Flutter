import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';

class UniScheduleFloatingActionButton extends StatelessWidget {
  const UniScheduleFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // TODO use a provider to automatically navigate depending on current route
        context.push(RouteConstants.newEvent);
      },
      backgroundColor: ColorConstants.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: ColorConstants.limerick, width: 3.8),
      ),
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: ColorConstants.limerick,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(0),
        child: SvgPicture.asset(
          AssetConstants.icSquarePlus,
          width: StyleConstants.fabIconSize,
          height: StyleConstants.fabIconSize,
          color: ColorConstants.white,
        ),
      ),
    );
  }
}