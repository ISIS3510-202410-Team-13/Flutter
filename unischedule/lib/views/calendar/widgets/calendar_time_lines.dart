import 'package:flutter/material.dart';

class CalendarTimeLines extends StatelessWidget {
  const CalendarTimeLines({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(50, (index) {

        if (index == 0) return const SizedBox(height: 6);
        if (index % 2 == 0) return const SizedBox(height: 60);

        final time = '${(index-1)~/2}:00';
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
