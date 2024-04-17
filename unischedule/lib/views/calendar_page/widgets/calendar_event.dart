import 'dart:math';

import 'package:flutter/material.dart';

class CalendarEvent extends StatelessWidget {
  const CalendarEvent({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.color,
  });

  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String color;

  @override
  Widget build(BuildContext context) {

    final startTime = '${startDate.toLocal().hour.toString()}:${startDate.toLocal().minute.toString().padLeft(2, '0')}';
    final endTime = '${endDate.toLocal().hour.toString()}:${endDate.toLocal().minute.toString().padLeft(2, '0')}';
    final duration = endDate.difference(startDate).inMinutes / 60;
    final minutesSinceMidnight = startDate.toLocal().hour * 60 + startDate.toLocal().minute;
    final dayOfWeek = startDate.toLocal().weekday;
    final dayOffset = dayOfWeek - 1;

    final fullWidth = MediaQuery.of(context).size.width - 80; // 30 offset + (25 + 25) padding
    const fullHeight = 24 * 70;  // Each hour 10 text + 60 sized box

    final boxWidth = fullWidth / 7;
    final boxHeight = fullHeight * duration / 24;

    final topOffset = fullHeight * minutesSinceMidnight / 1440 + 6; // 6 sized box
    final leftOffset = boxWidth * dayOffset + 30;  // 24 text + 6 sized box

    final colorHex = int.parse("0xFF${color.substring(1)}");

    return Positioned(
      top: topOffset,
      left: leftOffset,
      child: Stack(
        children: [
          Container(
            width: boxWidth,
            height: boxHeight,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            decoration: BoxDecoration(
              color: Color(colorHex).withOpacity(0.7),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: max(1, (duration * 2).floor()),  // NOTE this is empirical
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Text(
              startTime,
              style: const TextStyle(color: Colors.white, fontSize: 6),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Text(
              endTime,
              style: const TextStyle(color: Colors.white, fontSize: 6),
            ),
          ),
        ],
      ),
    );
  }
}