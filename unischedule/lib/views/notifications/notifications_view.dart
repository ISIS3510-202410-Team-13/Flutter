import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/repositories/notifications/notifications_repository.dart';
import 'widgets/notification_widget.dart';
import 'package:unischedule/models/notifications/notification_model.dart';
import 'package:unischedule/providers/providers.dart';
import 'package:unischedule/models/notifications/notification.dart' as model;

class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends ConsumerState<NotificationsView> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<void> _markAsRead(NotificationModel notification) async {
    final notificationsRepository = ref.read(notificationsRepositoryProvider);
    final updatedNotification = notification.copyWith(viewed: true);
    await notificationsRepository.saveNotification(updatedNotification);
    ref.refresh(fetchNotificationsProvider);
  }

  List<model.Notification> _mapToSpecificNotifications(List<NotificationModel> notifications) {
    return notifications.map((notification) {
      switch (notification.title) {
        case 'New Feature Alert!':
          return model.NewFeatureNotification(
            notification.title,
            notification.description,
            notification.id,
            notification.timeAgo,
            "https://storage.googleapis.com/unischedule-profile_pictures/logo.png",
            notification.viewed,
          );
      // Añadir aquí otros casos para los diferentes tipos de notificaciones
        default:
          return model.NewFeatureNotification(
            notification.title,
            notification.description,
            notification.id,
            notification.timeAgo,
            "https://storage.googleapis.com/unischedule-profile_pictures/logo.png",
            notification.viewed,
          );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final allNotificationsFuture = ref.watch(fetchNotificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Unread'),
            Tab(text: 'All'),
          ],
        ),
      ),
      body: allNotificationsFuture.when(
        data: (notificationModels) {
          // Invertir la lista de notificaciones
          final reversedNotificationModels = notificationModels.reversed.toList();

          final allNotifications = _mapToSpecificNotifications(reversedNotificationModels);
          final unreadNotifications = allNotifications.where((n) => !n.viewed).toList();

          return TabBarView(
            controller: _tabController,
            children: [
              // Pestaña de Notificaciones No Leídas
              ListView.builder(
                itemCount: unreadNotifications.length,
                itemBuilder: (context, index) {
                  final notification = unreadNotifications[index];
                  return GestureDetector(
                    onTap: () async {
                      final notificationModel = reversedNotificationModels.firstWhere((n) => n.id == notification.id);
                      if (!notificationModel.viewed) {
                        await _markAsRead(notificationModel);
                      }
                    },
                    child: NotificationWidget(notification),
                  );
                },
              ),
              // Pestaña de Todas las Notificaciones
              ListView.builder(
                itemCount: allNotifications.length,
                itemBuilder: (context, index) {
                  final notification = allNotifications[index];
                  return GestureDetector(
                    onTap: () async {
                      final notificationModel = reversedNotificationModels.firstWhere((n) => n.id == notification.id);
                      if (!notificationModel.viewed) {
                        await _markAsRead(notificationModel);
                      }
                    },
                    child: NotificationWidget(notification),
                  );
                },
              ),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      backgroundColor: const Color(0xFFF8F8F8),
    );
  }
}
