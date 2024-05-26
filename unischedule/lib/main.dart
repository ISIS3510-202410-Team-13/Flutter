import 'dart:ui';
import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/models/notifications/notification_model.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/routes/root_routes.dart';
import 'package:unischedule/services/services.dart';
import 'firebase_options.dart';
import 'package:unischedule/repositories/repositories.dart';


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  await setupLocalNotifications();
  await HiveBoxServiceFactory.initHive();
  await NotificationService().initNotification();

  runApp(
    const ProviderScope(
      child: UniScheduleApp(),
    )
  );
}

Future<void> setupLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosInitializationSetting = DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: iosInitializationSetting,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class UniScheduleApp extends ConsumerStatefulWidget {
  const UniScheduleApp({super.key});

  static const String _title = 'UniSchedule';

  @override
  ConsumerState<UniScheduleApp> createState() => _UniScheduleAppState();
}

class _UniScheduleAppState extends ConsumerState<UniScheduleApp> {
  late LifecycleObserver _lifecycleObserver;
  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    _lifecycleObserver = LifecycleObserver(ref);
    ref.read(registerEventProvider(eventName: AnalyticsConstants.APP_INIT));
    WidgetsBinding.instance.addObserver(_lifecycleObserver);
    _initializeFCM();
  }

  void _initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }

    _fcmToken = await messaging.getToken();
    print("FCM Token: $_fcmToken");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });
  }

void showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id', 'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );

  // Crear una instancia de NotificationModel
  final notification = NotificationModel(
    id: message.messageId ?? '',
    title: message.notification?.title ?? '',
    description: message.notification?.body ?? '',
    timeAgo: 'just now',
    imageUrl: '', // Asigna la URL de la imagen si está disponible
    viewed: false,
  );

  // Guardar la notificación en Hive
  final notificationsRepository = ref.read(notificationsRepositoryProvider);
  await notificationsRepository.saveNotification(notification);

  ref.refresh(fetchNotificationsProvider);
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
