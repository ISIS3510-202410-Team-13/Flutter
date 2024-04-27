import 'package:flutter/material.dart';

class BezierPainter extends CustomPainter {
  final Paint myPaint;

  BezierPainter(Color color) : myPaint = Paint()..color = color;

  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint()..color = myPaint.color;
    var path = Path();

    path.moveTo(size.width * 0.25, 0);

    path.quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.25,
        size.width * 0.5,
        size.height * 0.3
    );
    path.quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.35,
        size.width * 0.4,
        size.height * 0.6
    );
    path.quadraticBezierTo(
        size.width * 0.55,
        size.height * 0.8,
        size.width * 0.7,
        size.height * 0.9
    );
    path.quadraticBezierTo(
        size.width * 0.85,
        size.height,
        size.width,
        size.height * 0.75
    );

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
