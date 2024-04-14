import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'friend_model.freezed.dart';
part 'friend_model.g.dart';

@freezed
@HiveType(typeId: 1)
class Friend with _$Friend {
  const factory Friend({
    @HiveField(0)
    required String id,

    @HiveField(1)
    required String name,

    @HiveField(2)
    required String profilePicture,
  }) = _Friend;

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);
}
