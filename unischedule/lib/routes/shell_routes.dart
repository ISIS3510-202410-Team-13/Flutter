import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/views/views.dart';
import 'package:unischedule/widgets/widgets.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey(debugLabel: 'shell');

ShellRoute getShellRoute() {
  return ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: _getAppShell,
    routes: [
      _createRoute(RouteConstants.home, (state) => HomeView(key: state.pageKey)),
      _createRoute(RouteConstants.calendar, (state) => CalendarView(key: state.pageKey)),
      _createRoute(RouteConstants.friends, (state) => FriendsView(key: state.pageKey)),
      _createRoute(RouteConstants.groups, (state) => GroupsView(key: state.pageKey)),
    ],
  );
}

Widget _getAppShell(BuildContext context, GoRouterState state, Widget child) {
  String appBarTitle = '';
  Color appBarColor = ColorConstants.white;
  bool useFAB = false;
  switch(state.topRoute?.path) {
    case RouteConstants.calendar:
      appBarTitle = 'April';  // TODO implement dynamic month
      useFAB = true;
    case RouteConstants.friends:
      appBarTitle = StringConstants.friendsTitle;
      appBarColor = ColorConstants.black;
      useFAB = true;
    case RouteConstants.groups:
      appBarTitle = StringConstants.groupsTitle;
      appBarColor = ColorConstants.black;
      useFAB = true;
  }

  return UniScheduleAppShell(
    key: state.pageKey,
    body: child,
    appBarTitle: appBarTitle,
    appBarColor: appBarColor,
    useFAB: useFAB,
  );
}

GoRoute _createRoute(String path, Widget Function(GoRouterState state) builder) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) {
      return NoTransitionPage(child: builder(state));
    });
}