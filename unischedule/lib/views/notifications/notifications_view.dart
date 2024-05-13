// lib/notifications_view.dart
import 'package:flutter/material.dart';
import 'widgets/notifications_app_bar.dart';
import 'widgets/notification_widget.dart';
import 'package:unischedule/models/notifications/notification.dart' as model;



class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  // Listas de ejemplo para notificaciones
  List<model.Notification> allNotifications = [
    model.FriendRequestNotification('User 6', '5m', "https://storage.googleapis.com/unischedule-profile_pictures/user_7.png", false),
    model.MessageNotification('Friend 1', 'Looks perfect, send it for technical review tomorrow!', '1h', "https://storage.googleapis.com/unischedule-profile_pictures/user_1.png", false),
    model.NewFeatureNotification('New Feature Alert!', 'We’re pleased to introduce the latest enhancements in our scheduling experience.', '5h', "https://storage.googleapis.com/unischedule-profile_pictures/ICONO_SNOW_1.png", true),
    model.FileSharedNotification('Friend 2', 'File_name.docx', '512 KB', '7h', "https://storage.googleapis.com/unischedule-profile_pictures/user_2.png", true),
    model.GroupJoinedNotification('Friend 3 ', 'Group 2', '11h', "https://storage.googleapis.com/unischedule-profile_pictures/user_3.png", false),
      ];

  List<model.Notification> unreadNotifications = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Filtrar las notificaciones no leídas
    unreadNotifications = allNotifications.where((n) => !n.viewed).toList();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '      All      '),
            Tab(text: 'Unread'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Pestaña de Todas las Notificaciones
          ListView.builder(
            itemCount: allNotifications.length,
            itemBuilder: (context, index) => NotificationWidget(allNotifications[index]),
          ),
          // Pestaña de Notificaciones No Leídas
          ListView.builder(
            itemCount: unreadNotifications.length,
            itemBuilder: (context, index) => NotificationWidget(unreadNotifications[index]),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF8F8F8),
    );
  }
}
