import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/models/notifications/notification_model.dart';
import 'package:unischedule/repositories/repositories.dart';

part 'notifications_provider.g.dart';

// TODO add here all use cases as functions
@riverpod
Future<List<NotificationModel>> fetchNotifications(FetchNotificationsRef ref) {
  final notificationsRepository = ref.watch(notificationsRepositoryProvider);
  ref.keepAlive();

  return notificationsRepository.fetchNotifications();
}