import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/widgets/widgets.dart';
import 'widgets/calendar_event.dart';
import 'widgets/calendar_time_lines.dart';
import 'widgets/calendar_week_days.dart';

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends ConsumerState<CalendarView> {

  @override
  Widget build(BuildContext context) {

    final personalEvents = ref.watch(fetchEventsProvider);

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
                            const CalendarTimeLines(),
                            ...personalEvents.valueOrNull?.map((e) => CalendarEvent(
                              title: e.name,
                              startDate: DateTime.fromMillisecondsSinceEpoch(e.startDate["_seconds"]! * 1000),
                              endDate: DateTime.fromMillisecondsSinceEpoch(e.endDate["_seconds"]! * 1000),
                              color: e.color,
                            )).toList() ?? [], // TODO implement loading and error states
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


