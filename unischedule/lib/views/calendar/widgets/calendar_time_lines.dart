import 'package:flutter/material.dart';

class CalendarTimeLines extends StatelessWidget {

  final int? earliestStart;
  final int? latestEnd;
  
  const CalendarTimeLines({super.key, this.earliestStart, this.latestEnd});

  @override
Widget build(BuildContext context) {
  if (earliestStart == null || latestEnd == null) return Container(); // Or some placeholder

  int startHour = earliestStart!;
  int endHour = latestEnd!;

  return Column(
    children: List.generate((endHour - startHour + 1) * 2, (index) {
      if (index == 0) return const SizedBox(height: 6);
      if (index % 2 == 0) return SizedBox(height: 425/(endHour - startHour) * 1);

      final time = '${startHour + index ~/ 2}:00';
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.translate(
            offset: const Offset(0, -6),
            child: SizedBox(
              width: 24,
              height: 10,
              child: Text(
                time,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          const Expanded(
            child: Divider(
              color: Colors.white,
              thickness: 0.6,
              indent: 0.0,
              endIndent: 0.0,
              height: 0.6,
            ),
          ),
        ],
      );
    }),
  );
}

}
