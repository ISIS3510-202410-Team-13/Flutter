import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/utils/bezier_painter.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {

    final bgColor = ColorConstants.getColorFromString(event.color);
    Color shade = bgColor
        .withRed(max(0, bgColor.red - 30))
        .withGreen(max(0, bgColor.green - 30))
        .withBlue(max(0, bgColor.blue - 30));

    return Container(
      width: 234,
      height: 112,
      margin: const EdgeInsets.only(left: 19, right: 19, bottom: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                event.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: ColorConstants.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: BezierPainter(shade),
            ),
          ),
          Positioned(
            right: 8,
            top: 5,
            child: Column(
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.white,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 12,
            top: 12,
            child: SvgPicture.asset(
              'assets/icons/fire.svg',  //TODO Change this to a custom icon
              width: StyleConstants.iconWidth,
              height: StyleConstants.iconHeight,
              color: ColorConstants.white,
            ),
          ),
        ],
      ),
    );
  }
}