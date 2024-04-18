import 'package:flutter/material.dart';

class CalendarWeekDays extends StatelessWidget {
  const CalendarWeekDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> days = ['M 26', 'T 27', 'W 28', 'T 29', 'F 01', 'S 02', 'S 03'];
    return Padding(
      padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: 30.0
      ), // Espacio arriba y abajo para el padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days
            .map((day) => Text(
          day,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: day == 'W 28' ? 18 : 16,
            fontWeight:
            day == 'W 28' ? FontWeight.bold : FontWeight.normal,
            color: Colors.white,
          ),
        ))
            .toList(),
      ),
    );
  }
}
