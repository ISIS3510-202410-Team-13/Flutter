import 'package:flutter/material.dart';
import 'package:unischedule/constants/constants.dart';
import 'app_bar_widget.dart';
import 'app_fab_widget.dart';
import 'bottom_navbar_widget.dart';
import 'drawer_widget.dart';


class UniScheduleAppShell extends StatelessWidget {
  const UniScheduleAppShell({
    super.key,
    required this.body,
    required this.appBarTitle,
    required this.appBarColor,
    required this.useFAB,
  });
  final Widget body;
  final String appBarTitle;
  final Color appBarColor;
  final bool useFAB;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniScheduleAppBar(
        title: appBarTitle,
        color: appBarColor,
      ),
      body: body,
      extendBody: false,
      extendBodyBehindAppBar: true,
      backgroundColor: ColorConstants.desertStorm,
      bottomNavigationBar: const UniScheduleBottomNavBar(),
      drawer: const UniScheduleDrawer(),
      floatingActionButton: useFAB ? const UniScheduleFloatingActionButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
