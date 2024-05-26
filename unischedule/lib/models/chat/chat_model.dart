import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/models/chat/message_model.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
@HiveType(typeId: LocalStorageConstants.chatModelTypeId)
class ChatModel with _$ChatModel {
  const factory ChatModel({
    @HiveField(0) required String chatId,
    @HiveField(1) required String lastTyped,
    @HiveField(2) required List<MessageModel> messages,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) => _$ChatModelFromJson(json);
}