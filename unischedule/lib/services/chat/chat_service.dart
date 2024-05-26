import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unischedule/models/chat/message_model.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instanceFor(app: Firebase.app(), databaseId: 'unischedule-backend');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> sendMessage(String message, String receiverId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;
      final userId = user.uid;
      final userName = user.displayName!;
      final profilePicture = user.photoURL!;
      final timestamp = Timestamp.now();
      
      final messageModel = MessageModel(message: message, name: userName, profilePicture: profilePicture, senderId: userId, timestamp: timestamp);

      final ids = [userId, receiverId];
      ids.sort();
      final chatId = ids.join('_');

      await _firestore.collection('Chats').doc(chatId).collection('messages').add(messageModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getMessages(String receiverId) {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();
    final userId = user.uid;

    final ids = [userId, receiverId];
    ids.sort();
    final chatId = ids.join('_');

    return _firestore.collection('Chats').doc(chatId).collection('messages').orderBy('timestamp', descending: true).limit(50).snapshots();
  }
}