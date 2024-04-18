import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/constants/theme/app_theme.dart';
import 'package:unischedule/routes/root_routes.dart';
import 'package:unischedule/services/notifications_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  tz.initializeTimeZones();

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
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: appTheme(context),
      title: UniScheduleApp._title,
    );
  }
}