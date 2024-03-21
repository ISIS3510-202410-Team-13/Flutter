import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/presentation/calendar_page/calendar_page.dart';
import 'package:unischedule/presentation/notifications_page/notifications_page.dart';
import 'package:unischedule/presentation/shell/app_shell.dart';
import 'package:unischedule/presentation/home_page/home_page.dart';
import 'package:unischedule/presentation/authentication_page/authentication_page.dart';
import 'package:unischedule/presentation/notifications_page/notifications_page.dart';






final GlobalKey<NavigatorState> rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigator = GlobalKey(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigator,
    initialLocation: '/auth', // Cambio a la ruta de autenticación como inicial
    routes: [
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) {
          return AuthenticationPage(key: state.pageKey);
        },
      ),

      ShellRoute(
        navigatorKey: shellNavigator,
        builder: (context, state, child) => AppShell(key:state.pageKey, child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: HomePage(key: state.pageKey));
            }
          ),
          GoRoute(
            path: '/calendar',
            name: 'calendar',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: CalendarApp(key: state.pageKey));
            }
          ),
          GoRoute(
            path: '/friends',
            name: 'friends',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: NotificationsPage(key: state.pageKey, title: "Snow"));
            }
          ),
          GoRoute(
            path: '/groups',
            name: 'groups',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: HomePage(key: state.pageKey));
            }
          )
        ],
      )
    ],
  );
});