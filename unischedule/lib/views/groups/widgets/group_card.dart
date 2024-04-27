import 'dart:math';
import 'package:flutter/material.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/utils/bezier_painter.dart';
import 'profile_icons_row.dart';

class GroupCard extends StatelessWidget {
  final GroupModel group;
  const GroupCard({super.key, required this.group});

  @override
  Widget build(BuildContext context) {

    final bgColor = ColorConstants.getColorFromString(group.color);
    final shade = bgColor
        .withRed(max(0, bgColor.red - 50))
        .withGreen(max(0, bgColor.green - 50))
        .withBlue(max(0, bgColor.blue - 50));

    return Container(
      width: double.infinity,
      height: 133,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                group.name,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
          const Positioned(
            right: 10,
            top: 10,
            child: Column(
              children: [
                CircleAvatar(radius: 3, backgroundColor: ColorConstants.white),
                SizedBox(height: 3),
                CircleAvatar(radius: 3, backgroundColor: ColorConstants.white),
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 12,
            child: ProfileIconsRow(
              imagePaths: group.profilePictures,
              memberCount: group.memberCount,
            ),
          ),
        ],
      ),
    );
  }
}