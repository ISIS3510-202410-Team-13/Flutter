import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/views/views.dart';
import 'package:unischedule/widgets/widgets.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey(debugLabel: 'shell');

ShellRoute getShellRoute() {
  return ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) => UniScheduleAppShell(key: state.pageKey, body: child),
    routes: [
      _getHomeRoute(),
      _getCalendarRoute(),
      _getFriendsRoute(),
      _getGroupsRoute(),
    ],
  );
}

GoRoute _getHomeRoute() {
  return GoRoute(
    path: RouteConstants.home,
    builder: (context, state) {
      return HomeView(key: state.pageKey);
    });
}

GoRoute _getCalendarRoute() {
  return GoRoute(
    path: RouteConstants.calendar,
    builder: (context, state) {
      return CalendarApp(key: state.pageKey);
    });
}

GoRoute _getFriendsRoute() {
  return GoRoute(
    path: RouteConstants.friends,
    builder: (context, state) {
      return FriendsApp(key: state.pageKey);
    });
}

GoRoute _getGroupsRoute() {
  return GoRoute(
    path: RouteConstants.groups,
    builder: (context, state) {
      return GroupsPage(key: state.pageKey);
    }
  );
}