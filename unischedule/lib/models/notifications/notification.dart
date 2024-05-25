// lib/models/notification.dart
class Notification {
  final String id;  // Agregar el campo id
  final String timeAgo;
  final String imageUrl;
  final String type;
  final bool viewed;

  Notification(this.id, this.timeAgo, this.imageUrl, this.type, this.viewed);
}

class FriendRequestNotification extends Notification {
  final String userName;
  FriendRequestNotification(this.userName, String id, String timeAgo, String imageUrl, bool viewed)
      : super(id, timeAgo, imageUrl, 'FriendRequest', viewed);
}

class MessageNotification extends Notification {
  final String friendName;
  final String message;
  MessageNotification(this.friendName, this.message, String id, String timeAgo, String imageUrl, bool viewed)
      : super(id, timeAgo, imageUrl, 'Message', viewed);
}

class NewFeatureNotification extends Notification {
  final String title;
  final String description;
  NewFeatureNotification(this.title, this.description, String id, String timeAgo, String imageUrl, bool viewed)
      : super(id, timeAgo, imageUrl, 'NewFeature', viewed);
}

class FileSharedNotification extends Notification {
  final String friendName;
  final String fileName;
  final String fileSize;
  FileSharedNotification(this.friendName, this.fileName, this.fileSize, String id, String timeAgo, String imageUrl, bool viewed)
      : super(id, timeAgo, imageUrl, 'FileShared', viewed);
}

class GroupJoinedNotification extends Notification {
  final String friendName;
  final String groupName;
  GroupJoinedNotification(this.friendName, this.groupName, String id, String timeAgo, String imageUrl, bool viewed)
      : super(id, timeAgo, imageUrl, 'GroupJoined', viewed);
}

class ConnectivityNotification extends Notification {
  ConnectivityNotification(String id)
      : super(id, '', '', 'Connectivity', false);
}