import 'package:flutter/material.dart';
import 'app_bar_widget.dart';
import 'bottom_navbar_widget.dart';
import 'drawer_widget.dart';


class UniScheduleAppShell extends StatefulWidget {
  const UniScheduleAppShell({super.key, this.body});
  final Widget? body;

  @override
  State<UniScheduleAppShell> createState() => _UniScheduleAppShellState();
}

class _UniScheduleAppShellState extends State<UniScheduleAppShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UniScheduleAppBar(),
      body: widget.body,
      extendBody: false,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: const UniScheduleBottomNavBar(),
      drawer: const UniScheduleDrawer(),
    );
  }
}
