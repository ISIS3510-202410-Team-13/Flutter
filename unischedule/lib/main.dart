import 'dart:ui';
import 'package:timezone/data/latest.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/routes/root_routes.dart';
import 'package:unischedule/services/services.dart';
import 'firebase_options.dart';

Future<void> main() async {

  // Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  initializeTimeZones();

  // Services
  await HiveBoxServiceFactory.initHive();
  NotificationService().initNotification();

  runApp(
    const ProviderScope(
        child: UniScheduleApp(),
    )
  );
}

class UniScheduleApp extends ConsumerStatefulWidget {
  const UniScheduleApp({super.key});

  static const String _title = 'UniSchedule';

  @override
  ConsumerState<UniScheduleApp> createState() => _UniScheduleAppState();
}

class _UniScheduleAppState extends ConsumerState<UniScheduleApp> {
  @override
  Widget build(BuildContext context) {
    final goRouter = ref.watch(goRouterProvider);
    return _EagerInitialization(
      child: MaterialApp.router(
        routerConfig: goRouter,
        theme: appTheme(context),
        title: UniScheduleApp._title,
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(fetchEventsProvider);
    ref.watch(fetchFriendsProvider);
    ref.watch(fetchGroupsProvider);
    return child;
  }
}