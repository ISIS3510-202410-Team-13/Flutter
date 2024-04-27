import 'dart:ui';
import 'package:timezone/data/latest.dart' as tz;
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
  tz.initializeTimeZones();

  // Services
  await HiveBoxServiceFactory.initHive();
  await NotificationService().initNotification();

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

  late LifecycleObserver _lifecycleObserver;

  @override
  void initState() {
    super.initState();
    _lifecycleObserver = LifecycleObserver(ref);
    ref.read(registerEventProvider(eventName: AnalyticsConstants.APP_INIT));
    WidgetsBinding.instance.addObserver(_lifecycleObserver);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycleObserver);
    ref.read(registerEventProvider(eventName: AnalyticsConstants.APP_DISPOSED));
    super.dispose();
  }

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

class LifecycleObserver with WidgetsBindingObserver {
  LifecycleObserver(this.ref);
  final WidgetRef ref;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(registerEventProvider(eventName: AnalyticsConstants.APP_RESUMED));
        break;
      case AppLifecycleState.paused:
        ref.read(registerEventProvider(eventName: AnalyticsConstants.APP_PAUSED));
        break;
      case AppLifecycleState.inactive:
        ref.read(registerEventProvider(eventName: AnalyticsConstants.APP_INACTIVE));
        break;
      case AppLifecycleState.detached:
        ref.read(registerEventProvider(eventName: AnalyticsConstants.APP_DETACHED));
        break;
      case AppLifecycleState.hidden:
        ref.read(registerEventProvider(eventName: AnalyticsConstants.APP_HIDDEN));
        break;
    }
  }
}