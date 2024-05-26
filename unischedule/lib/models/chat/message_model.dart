import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:unischedule/constants/constants.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
@HiveType(typeId: LocalStorageConstants.messageModelTypeId)
class MessageModel with _$MessageModel {
  const factory MessageModel({
    @HiveField(0) required String message,
    @HiveField(1) required String name,
    @HiveField(2) required String profilePicture,
    @HiveField(3) required String senderId,
    @TimestampConverter()
    @HiveField(4) required Timestamp timestamp,
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

class TimestampAdapter extends TypeAdapter<Timestamp> {
  @override
  final int typeId = LocalStorageConstants.timestampModelTypeId;

  @override
  Timestamp read(BinaryReader reader) {
    final seconds = reader.readInt();
    final nanoseconds = reader.readInt();
    return Timestamp(seconds, nanoseconds);
  }

  @override
  void write(BinaryWriter writer, Timestamp obj) {
    writer.writeInt(obj.seconds);
    writer.writeInt(obj.nanoseconds);
  }
}
