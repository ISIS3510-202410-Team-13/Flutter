import 'package:flutter/material.dart';
import 'package:unischedule/models/notifications/notification.dart' as model;
import 'package:unischedule/constants/colors/color_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NotificationWidget extends StatelessWidget {
  final model.Notification notification;

  NotificationWidget(this.notification, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notification is model.ConnectivityNotification) {
      return Container(
        color: ColorConstants.gullGrey, // Fondo gris
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.warning, color: Colors.white), // Puedes cambiar el color si prefieres otro
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'No internet connection. You might be missing new notifications!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: notification.viewed ? Colors.white : Colors.lightGreen[50],
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0, style: BorderStyle.solid)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24), // Aplica el margen interno de 24px
        child: Row(
          children: <Widget>[
            // Usamos Stack para superponer el punto rojo sobre la imagen
            Stack(
              clipBehavior: Clip.none,  // Permite que el punto rojo se salga del stack
              children: [
                CachedNetworkImage(
                  imageUrl: notification.imageUrl,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 26.5, // 53px / 2 para ajustar el tamaño del círculo
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    radius: 26.5,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.image, color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 26.5,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                ),
                // Punto rojo para notificaciones no vistas, posicionado fuera del Stack
                if (!notification.viewed)
                  Positioned(
                    left: -10, // Ajusta según necesites para la posición correcta del punto
                    top: 22, // Ajusta para alinear verticalmente con la imagen
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor: ColorConstants.limerick,
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16), // Espacio entre la imagen y el texto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildSpecificPart(notification),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text(notification.timeAgo, style: TextStyle(fontSize: 12)),
                SizedBox(height: 4),
                Icon(Icons.more_horiz),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSpecificPart(model.Notification notification) {
    switch (notification.type) {
      case 'FriendRequest':
        return FriendRequestWidget(notification as model.FriendRequestNotification);
      case 'Message':
        return MessageWidget(notification as model.MessageNotification);
      case 'NewFeature':
        return NewFeatureWidget(notification as model.NewFeatureNotification);
      case 'FileShared':
        return FileSharedWidget(notification as model.FileSharedNotification);
      case 'GroupJoined':
        return GroupJoinedWidget(notification as model.GroupJoinedNotification);
      case 'Connectivity':
        return Text(
          'No internet connection. You might be missing new notifications!',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        );
      default:
        return SizedBox();
    }
  }
}

class FriendRequestWidget extends StatelessWidget {
  final model.FriendRequestNotification notification;

  FriendRequestWidget(this.notification, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '${notification.userName} ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Poppins')),
              TextSpan(text: 'has sent you a friend request', style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'Poppins')),
            ],
          ),
        ),
        SizedBox(height: 6),  // Espacio entre el texto y los botones
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: ColorConstants.limerick,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorConstants.limerick, width: 1),
              ),
              child: Text('Accept', style: TextStyle(fontSize: 14, color: ColorConstants.white, fontFamily: 'Poppins')),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFFD0D5DD), width: 1),
              ),
              child: Text('Decline', style: TextStyle(fontSize: 14, color: Color(0xFF475569), fontFamily: 'Poppins')),
            ),
          ],
        ),
      ],
    );
  }
}

class MessageWidget extends StatelessWidget {
  final model.MessageNotification notification;

  MessageWidget(this.notification, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '${notification.friendName} ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Poppins')),
              TextSpan(text: 'sent a message to Group 1:', style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'Poppins')),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.grey[300]!, width: 4)),  // Línea vertical gruesa
            ),
            padding: const EdgeInsets.only(left: 8.0),  // Espacio entre la línea y el texto
            child: Text(notification.message, style: TextStyle(fontSize: 12, fontFamily: 'Poppins')),
          ),
        ),
      ],
    );
  }
}

class NewFeatureWidget extends StatelessWidget {
  final model.NewFeatureNotification notification;

  NewFeatureWidget(this.notification, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: notification.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Poppins')),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6), // Espacio sobre el botón
          child: Text(notification.description, style: TextStyle(fontSize: 14, fontFamily: 'Poppins')),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: ColorConstants.limerick,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorConstants.limerick, width: 1),
          ),
          child: Text('Try now', style: TextStyle(fontSize: 14, color: ColorConstants.white, fontFamily: 'Poppins')),
        ),
      ],
    );
  }
}

class FileSharedWidget extends StatelessWidget {
  final model.FileSharedNotification notification;

  FileSharedWidget(this.notification, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '${notification.friendName} ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Poppins')),
              TextSpan(text: 'has shared a file with you', style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'Poppins')),
            ],
          ),
        ),
        SizedBox(height: 4),  // Espacio entre el texto y la fila del archivo
        Row(
          children: <Widget>[
            Icon(Icons.insert_drive_file, size: 20, color: Color(0xFF9DCC18)), // Icono de archivo
            SizedBox(width: 4),
            Text(notification.fileName, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            SizedBox(width: 4),
            Text(notification.fileSize, style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

class GroupJoinedWidget extends StatelessWidget {
  final model.GroupJoinedNotification notification;

  GroupJoinedWidget(this.notification, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '${notification.friendName} ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black,fontFamily: 'Poppins')),
              TextSpan(text: 'has joined .', style: TextStyle(fontSize: 14, color: Colors.black,fontFamily: 'Poppins')),
              TextSpan(text: '${notification.groupName}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black,fontFamily: 'Poppins')),
            ],
          ),
        ),
      ],
    );
  }
}
