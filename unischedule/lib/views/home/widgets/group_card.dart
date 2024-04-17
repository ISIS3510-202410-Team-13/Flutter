import 'dart:math';
import 'package:flutter/material.dart';
import 'package:unischedule/models/groups_page/group_model.dart';
import 'package:unischedule/utils/bezier_painter.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.group
  });

  final Group group;

  @override
  Widget build(BuildContext context) {

    String formattedName = group.name.length > 7 ? '${group.name.substring(0, 7)}...' : group.name;
    final bgColor = Color(int.parse(group.color.replaceAll('#', '0xff')));
    Color colorMasOscuro = bgColor
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
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                formattedName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: BezierPainter(colorMasOscuro),
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 3),
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
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
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}