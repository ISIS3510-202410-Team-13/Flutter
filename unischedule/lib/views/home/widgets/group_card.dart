import 'dart:math';
import 'package:flutter/material.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/utils/bezier_painter.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.group
  });

  final GroupModel group;

  @override
  Widget build(BuildContext context) {

    final bgColor = ColorConstants.getColorFromString(group.color);
    Color shade = bgColor
        .withRed(max(0, bgColor.red - 30))
        .withGreen(max(0, bgColor.green - 30))
        .withBlue(max(0, bgColor.blue - 30));

    return Container(
      width: 150,
      height: 112,
      margin: const EdgeInsets.only(left: 19, right: 19, bottom: 15),
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
                group.name,
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
            left: 14,
            top: 8,
            child: Text(
              group.icon,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}