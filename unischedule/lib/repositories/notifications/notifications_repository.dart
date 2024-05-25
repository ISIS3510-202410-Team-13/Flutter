import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/notifications/notification_model.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/services.dart';
import 'package:unischedule/providers/providers.dart';

part 'notifications_repository.g.dart';

abstract class NotificationsRepository {
  Future<List<NotificationModel>> fetchNotifications();
  Future<void> saveNotification(NotificationModel notification);
}

class NotificationsRepositoryImpl extends NotificationsRepository {

  final DioApiService client;
  final HiveBoxService<NotificationModel> boxService;
  final Ref ref;

  NotificationsRepositoryImpl({
    required this.ref,
    required this.client,
    required this.boxService,
  });

  @override
  Future<List<NotificationModel>> fetchNotifications() async {

    List<NotificationModel> notifications = boxService.getAll();

    return notifications;
  }

  @override
  Future<void> saveNotification(NotificationModel notification) async {
    await boxService.put(notification.id, notification);
  }
}


@riverpod
NotificationsRepositoryImpl notificationsRepository(NotificationsRepositoryRef ref) {
  return NotificationsRepositoryImpl(
    ref: ref,
    client: DioApiServiceFactory.getService(HTTPConstants.NOTIFICATIONS_BASE_URL),
    boxService: HiveBoxServiceFactory.notificationModelBox,
  );
}