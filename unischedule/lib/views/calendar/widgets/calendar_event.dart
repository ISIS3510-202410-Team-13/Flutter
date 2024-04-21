import 'dart:math';
import 'package:flutter/material.dart';
import 'package:unischedule/constants/constants.dart';

class CalendarEvent extends StatelessWidget {
  const CalendarEvent({
    super.key,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.color,
    required this.earliestStart,
    required this.latestEnd,
  });

  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String color;
  final int earliestStart;
  final int latestEnd;

  @override
  Widget build(BuildContext context) {

    int startHour = earliestStart;
    int endHour = latestEnd;

    final startTime = '${startDate.toLocal().hour.toString()}:${startDate.toLocal().minute.toString().padLeft(2, '0')}';
    final endTime = '${endDate.toLocal().hour.toString()}:${endDate.toLocal().minute.toString().padLeft(2, '0')}';
    final duration = endDate.difference(startDate).inMinutes / 60;
    final minutesSinceMidnight = startDate.toLocal().hour * 60 + startDate.toLocal().minute - (startHour * 60);
    final dayOfWeek = startDate.toLocal().weekday;
    final dayOffset = dayOfWeek - 1;

    final fullWidth = MediaQuery.of(context).size.width - 80; // 30 offset + (25 + 25) padding
    final fullHeight = (endHour-startHour) * (500/(endHour-startHour)+10);  // Each hour 10 text + 60 sized box

    final boxWidth = fullWidth / 7;
    final boxHeight = fullHeight * duration / (endHour-startHour);

    final topOffset = fullHeight * minutesSinceMidnight / ((endHour-startHour)*60) + 6; // 6 sized box
    final leftOffset = boxWidth * dayOffset + 30;  // 24 text + 6 sized box

    final colorHex = ColorConstants.getColorFromString(color);

    return Positioned(
      top: topOffset,
      left: leftOffset,
      child: Stack(
        children: [
            Container(
            width: boxWidth,
            height: boxHeight,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            decoration: BoxDecoration(
              color: colorHex.withOpacity(0.7),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.normal,  fontFamily: 'Poppins'),
              maxLines: max(1, (duration * 2).floor()),  // NOTE this is empirical
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center, // Add this line to center the text
              ),
            ),
            ),
          Positioned(
            top: 2,
            left: 3,
            child: Text(
              startTime,
              style: const TextStyle(color: Colors.white, fontSize: 6),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 3,
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