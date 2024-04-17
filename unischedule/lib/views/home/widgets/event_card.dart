import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unischedule/utils/bezier_painter.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final index = 1;
    return Container(
      width: 234,
      height: 112,
      // Añade un margen en la parte inferior además de los márgenes horizontales
      margin: const EdgeInsets.only(left: 19, right: 19, bottom: 20),
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Color(0xFFFF7878) : Color(0xFF78BEFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Event $index',
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
              painter: BezierPainter(index % 2 == 0 ? Color(0xFFFF4848) : Color(0XFF4870FF)),
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
            left: 12,
            top: 12,
            child: SvgPicture.asset(
              'assets/icons/fire.svg',
              width: 24,
              height: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
