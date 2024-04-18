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
      _getRootRoute(),
      _getNotificationsRoute(),
      _getChatRoute(),
      getShellRoute(),
    ],
  );
});

GoRoute _getRootRoute() {
  return GoRoute(
    path: RouteConstants.root,
    builder: (context, state) {
      return AuthenticationView(key: state.pageKey);
    },
  );
}

GoRoute _getNotificationsRoute() {
  return GoRoute(
    path: RouteConstants.notifications,
    builder: (context, state) {
      return NotificationsView(key: state.pageKey);
    },
  );
}

GoRoute _getChatRoute() {
  return GoRoute(
    path: RouteConstants.chat,
    builder: (context, state) {
      return ChatView(key: state.pageKey);
    },
  );
}