import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:unischedule/constants/constants.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
@HiveType(typeId: LocalStorageConstants.groupModelTypeId)
class GroupModel with _$GroupModel {
  const factory GroupModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String groupPicture,
    @HiveField(3) required String color,
    @HiveField(4) required List<String> members,
    @HiveField(5) required String icon,
    @HiveField(6) required List<String> events,
    @HiveField(7) required List<String> profilePictures,
    @HiveField(8) required int memberCount,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) => _$GroupModelFromJson(json);
}