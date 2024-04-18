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
      _getHomeRoute(),
      _getCalendarRoute(),
      _getFriendsRoute(),
      _getGroupsRoute(),
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

GoRoute _getHomeRoute() {
  return GoRoute(
    path: RouteConstants.home,
    pageBuilder: (context, state) {
      return NoTransitionPage(child: HomeView(key: state.pageKey));
    });
}

GoRoute _getCalendarRoute() {
  return GoRoute(
    path: RouteConstants.calendar,
    pageBuilder: (context, state) {
      return NoTransitionPage(child: CalendarView(key: state.pageKey));
    });
}

GoRoute _getFriendsRoute() {
  return GoRoute(
    path: RouteConstants.friends,
    pageBuilder: (context, state) {
      return NoTransitionPage(child: FriendsView(key: state.pageKey));
    });
}

GoRoute _getGroupsRoute() {
  return GoRoute(
    path: RouteConstants.groups,
    pageBuilder: (context, state) {
      return NoTransitionPage(child: GroupsView(key: state.pageKey));
    }
  );
}