import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/widgets/widgets.dart';
import 'app_bar_widget.dart';
import 'app_fab_widget.dart';
import 'bottom_navbar_widget.dart';
import 'drawer_widget.dart';


class UniScheduleAppShell extends ConsumerStatefulWidget {
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
  ConsumerState<UniScheduleAppShell> createState() => _UniScheduleAppShellState();
}

class _UniScheduleAppShellState extends ConsumerState<UniScheduleAppShell> {
  @override
  Widget build(BuildContext context) {

    ref.listen(connectivityStatusProvider, (previous, next) {
      var isDisconnected = next == ConnectivityStatus.isDisconnected;
      if (isDisconnected) {
        showSnackBar(context, StringConstants.connectivityError);
      } else if ((previous == ConnectivityStatus.isDisconnected) && (next == ConnectivityStatus.isConnected)) {
        showSnackBar(context, StringConstants.connectivityRestored);
      }
    });

    return Scaffold(
      appBar: UniScheduleAppBar(
        title: widget.appBarTitle,
        color: widget.appBarColor,
      ),
      body: widget.body,
      extendBody: false,
      extendBodyBehindAppBar: true,
      backgroundColor: ColorConstants.desertStorm,
      bottomNavigationBar: const UniScheduleBottomNavBar(),
      drawer: const UniScheduleDrawer(),
      floatingActionButton: widget.useFAB ? const UniScheduleFloatingActionButton() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
