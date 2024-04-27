import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('unischedule_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) =>
        showNotification(id: id, title: title, body: body, payLoad: payload)
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {}
    );
    await requestPermission();
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max
        ),
        iOS: DarwinNotificationDetails());
  }

  Future<PermissionStatus> requestPermission() async {
    var settings = await Permission.notification.request();
    await notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    await notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
    return settings;
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad
  }) async {
    return notificationsPlugin.show(
      id, title, body, notificationDetails()
    );
  }

  Future<void> scheduleNotification({
      int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime
  }) async {
    return notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}