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

    int? earliestStart;
    int? latestEnd;

    personalEvents.when(
      data: (events) {
        for (var event in events) {
          if (earliestStart == null || DateTime.fromMillisecondsSinceEpoch(event.startDate['_seconds']! * 1000).hour < earliestStart!) {
            earliestStart =  DateTime.fromMillisecondsSinceEpoch(event.startDate['_seconds']! * 1000).hour;
          }
          if (latestEnd == null || DateTime.fromMillisecondsSinceEpoch(event.endDate['_seconds']! * 1000).hour > latestEnd!) {
            latestEnd = DateTime.fromMillisecondsSinceEpoch(event.endDate['_seconds']! * 1000).hour;
          }
        }
        if (latestEnd! < 23) {
          latestEnd = latestEnd! + 1;
        }
        print([earliestStart, latestEnd]);
        // Ahora puedes usar earliestStart y latestEnd aquí dentro para calcular y mostrar lo que necesitas
      },
      error: (error, stack) => {},
      loading: () => {} /* manejar loading */
    );

    return Stack(
      children: <Widget>[
        const BackgroundImage(opacity: StyleConstants.backgroundOpacity),
        Column(
          children: [
            SizedBox(height: Scaffold.of(context).appBarMaxHeight),
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
                            CalendarTimeLines(earliestStart: earliestStart, latestEnd: latestEnd),
                            ...personalEvents.when(
                              data: (events) => events.map((event) => CalendarEvent(
                                title: event.name,
                                startDate: DateTime.fromMillisecondsSinceEpoch(event.startDate['_seconds']! * 1000),
                                endDate: DateTime.fromMillisecondsSinceEpoch(event.endDate['_seconds']! * 1000),
                                color: event.color,
                                earliestStart: earliestStart!,
                                latestEnd: latestEnd!,
                              )).toList(),
                              error: (error, _) => <Widget>[],
                              loading: () => const [Center(child: CircularProgressIndicator())],
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


