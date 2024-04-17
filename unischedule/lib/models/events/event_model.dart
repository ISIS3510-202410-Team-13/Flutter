import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
@HiveType(typeId: 2)
class EventModel with _$EventModel {
  const factory EventModel({
    @HiveField(0) required String id,
    @HiveField(1) required String color,
    @HiveField(2) required int reminder,
    @HiveField(3) required Map<String, int> endDate,
    @HiveField(4) required String name,
    @HiveField(5) required String description,
    @HiveField(6) required Map<String, int> startDate,
    @HiveField(7) required List<String> labels,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);
}
