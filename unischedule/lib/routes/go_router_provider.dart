import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:unischedule/presentation/calendar_page/calendar_page.dart';
import 'package:unischedule/presentation/gotty_page/gotty_page.dart';
import 'package:unischedule/presentation/home_page/home_page.dart';





final GlobalKey<NavigatorState> rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigator = GlobalKey(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigator,
    initialLocation: '/',
    routes: [
      GoRoute( 
        path: '/home',
        name: 'root',
        builder: (context, state) {
          return MyApp(key: state.pageKey);
        }
      ),

      ShellRoute(
        navigatorKey: shellNavigator,
        builder: (context, state, child) => DashboardScreen(key:state.pageKey, child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: MyApp(key: state.pageKey));
            }
          ),
          GoRoute(
            path: '/calendar',
            name: 'calendar',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: GottyApp(key: state.pageKey));
            }
          ),
          GoRoute(
            path: '/friends',
            name: 'friends',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: GottyApp(key: state.pageKey));
            }
          ),
          GoRoute(
            path: '/groups',
            name: 'groups',
            pageBuilder: (context, state) {
              return NoTransitionPage(child: GottyApp(key: state.pageKey));
            }
          )
        ],
      )
    ],
  );
});