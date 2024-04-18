import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:unischedule/constants/constants.dart';

part 'friend_model.freezed.dart';
part 'friend_model.g.dart';

@freezed
@HiveType(typeId: LocalStorageConstants.friendModelTypeId)
class FriendModel with _$FriendModel {
  const factory FriendModel ({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String profilePicture,
  }) = _FriendModel;

  factory FriendModel.fromJson(Map<String, dynamic> json) => _$FriendModelFromJson(json);
}