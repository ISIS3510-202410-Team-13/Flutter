import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:unischedule/constants/constants.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
@HiveType(typeId: LocalStorageConstants.notificationModelTypeId)
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(3) required String description,
    @HiveField(4) required String timeAgo,
    @HiveField(5) required String imageUrl,
    @HiveField(6) required bool viewed,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
}