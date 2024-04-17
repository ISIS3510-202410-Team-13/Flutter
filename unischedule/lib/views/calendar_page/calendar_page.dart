import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/views/calendar_page/widgets/calendar_event.dart';

import '../../../providers/events_page/events_state_notifier.dart';

import 'widgets/calendar_background.dart';
import 'widgets/calendar_time_lines.dart';
import 'widgets/calendar_app_bar.dart';
import 'widgets/calendar_fab.dart';
import 'widgets/calendar_week_days.dart';

class CalendarApp extends ConsumerStatefulWidget {
  const CalendarApp({Key? key}) : super(key: key);

  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends ConsumerState<CalendarApp> {

  @override
  Widget build(BuildContext context) {

    final personalEvents = ref.watch(eventsStateNotifierProvider);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const CalendarAppBackground(),
          Column(
            children: [
              const CalendarAppBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  child: Column(
                    children: [
                      const CalendarWeekDays(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Stack(
                            children: [
                              const CalendarTimeLines(),
                              ...personalEvents.map((e) => CalendarEvent(
                                title: e.name,
                                startDate: DateTime.fromMillisecondsSinceEpoch(e.startDate["_seconds"]! * 1000),
                                endDate: DateTime.fromMillisecondsSinceEpoch(e.endDate["_seconds"]! * 1000),
                                color: e.color,
                              )).toList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          CalendarFAB(),
        ],
      ),
    );
  }
}


