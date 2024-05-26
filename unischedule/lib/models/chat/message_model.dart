import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String message,
    required String name,
    required String profilePicture,
    required String senderId,
    @TimestampConverter()
    required Timestamp timestamp,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}

class TimestampConverter implements JsonConverter<Timestamp, dynamic> {
  const TimestampConverter();

  @override
  Timestamp fromJson(dynamic json) {
    if (json == null) {
      throw Exception('Timestamp cannot be null');
    }
    if (json is Timestamp) {
      return json;
    }
    if (json is Map<String, dynamic> && json.containsKey('_seconds') && json.containsKey('_nanoseconds')) {
      return Timestamp(json['_seconds'] as int, json['_nanoseconds'] as int);
    }
    throw Exception('Invalid timestamp format');
  }

  @override
  dynamic toJson(Timestamp timestamp) => timestamp;
}
