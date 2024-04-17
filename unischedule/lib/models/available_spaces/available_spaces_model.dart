import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_spaces_model.freezed.dart';
part 'available_spaces_model.g.dart';

@freezed
class AvailableSpacesModel with _$AvailableSpacesModel {
  const factory AvailableSpacesModel({
    required String building,
    required String room,
    required String availableFrom,
    required String availableUntil,
    required int minutesAvailable,
  }) = _AvailableSpacesModel;

  factory AvailableSpacesModel.fromJson(Map<String, dynamic> json) => _$AvailableSpacesModelFromJson(json);
}

