import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/views/new_group/new_group_view.dart';
import 'package:unischedule/views/views.dart';
import 'shell_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey(debugLabel: 'root');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteConstants.root,
    observers: [GoRouterObserver(ref)],
    routes: [
      getShellRoute(),
      _createRoute(RouteConstants.root, (state) => AuthenticationView(key: state.pageKey)),
      _createRoute(RouteConstants.notifications, (state) => NotificationsView(key: state.pageKey)),
      _createRoute(RouteConstants.chat, (state) => ChatView(key: state.pageKey, otherUserId: state.extra as String)),
      _createRoute(RouteConstants.newEvent, (state) => NewEventView(key: state.pageKey)),
      _createRoute(RouteConstants.newGroup, (state) => NewGroupView(key: state.pageKey)),
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

class GoRouterObserver extends NavigatorObserver {
  GoRouterObserver(this.ref);
  final ProviderRef<GoRouter> ref;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    ref.read(registerPageViewProvider(pageName: route.settings.name ?? 'Unknown'));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    ref.read(registerPageViewProvider(pageName: route.settings.name ?? 'Unknown'));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    ref.read(registerPageViewProvider(pageName: route.settings.name ?? 'Unknown'));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    ref.read(registerPageViewProvider(pageName: newRoute?.settings.name ?? 'Unknown'));
  }
}