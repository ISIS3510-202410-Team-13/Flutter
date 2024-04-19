import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/views/views.dart';
import 'shell_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey(debugLabel: 'root');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteConstants.root,
    routes: [
      getShellRoute(),
      _createRoute(RouteConstants.root, (state) => AuthenticationView(key: state.pageKey)),
      _createRoute(RouteConstants.notifications, (state) => NotificationsView(key: state.pageKey)),
      _createRoute(RouteConstants.chat, (state) => ChatView(key: state.pageKey)),
      _createRoute(RouteConstants.newEvent, (state) => NewEventView(key: state.pageKey)),
    ],
  );
});

GoRoute _createRoute(String path, Widget Function(GoRouterState state) builder) {
  return GoRoute(
    path: path,
    builder: (context, state) {
      return builder(state);
    },
  );
}