import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
class Group with _$Group {
  const factory Group({
    required String id,
    required String name,
    required String groupPicture,
    required String color,
    required List<String> members,
    required String icon,
    required List<String> events,
    required List<String> profilePictures,
    required int memberCount,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
