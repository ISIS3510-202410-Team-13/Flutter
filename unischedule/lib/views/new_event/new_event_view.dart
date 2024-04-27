import 'package:flutter/material.dart';
import 'package:unischedule/views/new_event/widgets/new_event_form.dart';
import 'widgets/new_event_app_bar.dart';


class NewEventView extends StatelessWidget {
  const NewEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NewEventForm(),
      appBar: NewEventAppBar(),
      backgroundColor: Color(0xFFF8F8F8),  // TODO use a Color constant
    );
  }
}
