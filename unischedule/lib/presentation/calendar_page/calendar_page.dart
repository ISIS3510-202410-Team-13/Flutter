import 'package:flutter/material.dart';

import 'widgets/calendar_background.dart';
import 'widgets/calendar_time_lines.dart';
import 'widgets/calendar_app_bar.dart';
import 'widgets/calendar_fab.dart';
import 'widgets/calendar_week_days.dart';

class CalendarApp extends StatefulWidget {
  const CalendarApp({Key? key}) : super(key: key);

  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: <Widget>[
          CalendarAppBackground(),
          CalendarFAB(),
          Column(
            children: [
              CalendarAppBar(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      25, 0, 40, 0), // Margen aplicado solo a los lados
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Alinea el contenido al inicio de la columna
                    children: [
                      CalendarWeekDays(),
                      Expanded(
                        child: CalendarTimeLines(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


