import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unischedule/models/chat/message_model.dart';
import 'package:unischedule/models/models.dart';
import 'package:unischedule/services/local_storage/hive_box_service.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instanceFor(app: Firebase.app(), databaseId: 'unischedule-backend');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final HiveBoxService<ChatModel> boxService = HiveBoxServiceFactory.chatModelBox;

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

  Stream<ChatModel> getMessages(String receiverId) {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();
    final userId = user.uid;

    final ids = [userId, receiverId];
    ids.sort();
    final chatId = ids.join('_');

    return _firestore
      .collection('Chats')
      .doc(chatId)
      .collection('messages')
      .orderBy('timestamp', descending: true)
      .limit(50)
      .snapshots()
      .map((snapshot) {
        final messages = snapshot.docs.reversed.map((doc) => MessageModel.fromJson(doc.data())).toList();
        final savedChat = boxService.get(chatId);
        String lastTyped = '';
        if (savedChat != null) {
          lastTyped = savedChat.lastTyped;
        }
        final chat = ChatModel(chatId: chatId, lastTyped: lastTyped, messages: messages);
        boxService.put(chatId, chat);
        return chat;
      })
      .handleError((error) {
        final savedChat = boxService.get(chatId);
        return savedChat ?? ChatModel(chatId: chatId, lastTyped: '', messages: []);
      });
  }

  void updateLastTyped(String otherUserId, String lastTyped) {
    final user = _auth.currentUser;
    if (user == null) return;
    final userId = user.uid;
    final ids = [userId, otherUserId];
    ids.sort();
    final chatId = ids.join('_');
    final chat = boxService.get(chatId);
    if (chat != null) {
      boxService.put(chatId, ChatModel(chatId: chatId, lastTyped: lastTyped, messages: chat.messages));
    }
  }

  String getLastTyped(String otherUserId) {
    final user = _auth.currentUser;
    if (user == null) return '';
    final userId = user.uid;
    final ids = [userId, otherUserId];
    ids.sort();
    final chatId = ids.join('_');
    final chat = boxService.get(chatId);
    return chat?.lastTyped ?? '';
  }
}