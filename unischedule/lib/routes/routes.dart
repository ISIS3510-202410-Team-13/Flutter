import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/views/calendar_page/calendar_page.dart';
import 'package:unischedule/views/create-class_page/create-class_page.dart';
import 'package:unischedule/views/shell/app_shell.dart';
import 'package:unischedule/views/home/home_view.dart';
import 'package:unischedule/views/authentication/authentication_page.dart';
import 'package:unischedule/views/friends_page/friends_page.dart';
import 'package:unischedule/views/groups_page/groups_page.dart';
import 'package:unischedule/views/temp-cache_page/temp-cache_page.dart';


final GlobalKey<NavigatorState> rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigator = GlobalKey(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigator,
    initialLocation: '/auth',
    routes: [
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) {
          return AuthenticationPage(key: state.pageKey);
        },
      ),
      GoRoute(
          path: '/create-class',
          name: 'create-class',
          builder: (context, state) {
            return CreateClassPage(key: state.pageKey);
          }),
      GoRoute(
          path: '/temp-cache',
          name: 'temp-cache',
          builder: (context, state) {
            return TempCachePage(key: state.pageKey);
          }),
      ShellRoute(
        navigatorKey: shellNavigator,
        builder: (context, state, child) =>
            AppShell(key: state.pageKey, child: child),
        routes: [
          GoRoute(
              path: '/home',
              name: 'home',
              pageBuilder: (context, state) {
                return NoTransitionPage(child: HomeView(key: state.pageKey));
              }),
          GoRoute(
              path: '/calendar',
              name: 'calendar',
              pageBuilder: (context, state) {
                return NoTransitionPage(child: CalendarApp(key: state.pageKey));
              }),
          GoRoute(
              path: '/friends',
              name: 'friends',
              pageBuilder: (context, state) {
                return NoTransitionPage(child: FriendsApp(key: state.pageKey));
              }),
          GoRoute(
              path: '/groups',
              name: 'groups',
              pageBuilder: (context, state) {
                return NoTransitionPage(child: GroupsPage(key: state.pageKey));
              })
        ],
      )
    ],
  );
});
