import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/widgets/widgets.dart';
import 'widgets/calendar_event.dart';
import 'widgets/calendar_time_lines.dart';
import 'widgets/calendar_week_days.dart';

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({super.key});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends ConsumerState<CalendarView> {
  @override
  Widget build(BuildContext context) {
    final personalEvents = ref.watch(fetchEventsProvider);

    late int earliestStart;
    late int latestEnd;

   personalEvents.when(
    data: (events) {
      earliestStart = 8;
      latestEnd = 17;

      events.forEach((event) {
        final startDate = DateTime.fromMillisecondsSinceEpoch(event.startDate['_seconds']! * 1000);
        final endDate = DateTime.fromMillisecondsSinceEpoch(event.endDate['_seconds']! * 1000);

        earliestStart = min(earliestStart, startDate.hour);
        latestEnd = max(latestEnd, endDate.hour);

        if (startDate.day != endDate.day) {
          earliestStart = 0;
          latestEnd = 23;
          return;
        }
      });
      latestEnd = min(latestEnd + 1, 24);
      print([events.isEmpty, earliestStart, latestEnd]);
    },
    error: (error, stack) => print("Error: $error"), // Print basic error message
    loading: () => print("Loading..."), // Print loading message
  );


    return Stack(
      children: <Widget>[
        const BackgroundImage(opacity: StyleConstants.backgroundOpacity),
        Column(
          children: [
            SizedBox(height: Scaffold.of(context).appBarMaxHeight),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                child: Column(
                  children: [
                    const CalendarWeekDays(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            CalendarTimeLines(
                                earliestStart: earliestStart,
                                latestEnd: latestEnd),
                            ...personalEvents.when(
                              data: (events) => events.expand((event) {
                                final startDateTime =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        event.startDate['_seconds']! * 1000);
                                final endDateTime =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        event.endDate['_seconds']! * 1000);
                                final eventsList = <Widget>[];
                                if (DateTime.fromMillisecondsSinceEpoch(
                                            event.startDate['_seconds']! * 1000)
                                        .day ==
                                    DateTime.fromMillisecondsSinceEpoch(
                                            event.endDate['_seconds']! * 1000)
                                        .day) {
                                  eventsList.add(
                                    CalendarEvent(
                                      title: event.name,
                                      startDate: startDateTime,
                                      endDate: endDateTime,
                                      color: event.color,
                                      earliestStart: earliestStart!,
                                      latestEnd: latestEnd!,
                                    ),
                                  );
                                } else {
                                  final firstEventEndDateTime = DateTime(
                                      startDateTime.year,
                                      startDateTime.month,
                                      startDateTime.day,
                                      23,
                                      59);
                                  final secondEventStartDateTime = DateTime(
                                      endDateTime.year,
                                      endDateTime.month,
                                      endDateTime.day,
                                      0,
                                      0);
                                  eventsList.add(
                                    CalendarEvent(
                                      title: event.name,
                                      startDate: startDateTime,
                                      endDate: firstEventEndDateTime,
                                      color: event.color,
                                      earliestStart: earliestStart!,
                                      latestEnd: latestEnd!,
                                    ),
                                  );
                                  eventsList.add(
                                    CalendarEvent(
                                      title: event.name,
                                      startDate: secondEventStartDateTime,
                                      endDate: endDateTime,
                                      color: event.color,
                                      earliestStart: earliestStart!,
                                      latestEnd: latestEnd!,
                                    ),
                                  );
                                }
                                return eventsList;
                              }).toList(),
                              error: (error, _) => <Widget>[],
                              loading: () => const [
                                Center(child: CircularProgressIndicator())
                              ],
                            )
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
      ],
    );
  }
}
