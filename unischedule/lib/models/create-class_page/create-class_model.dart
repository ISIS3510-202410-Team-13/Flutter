import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create-class_model.freezed.dart';
part 'create-class_model.g.dart';

// Troubleshooting:
// Execute dart run build_runner build in the terminal to generate the files

@freezed
class AvailableSpacesRequestModel with _$AvailableSpacesRequestModel {
  const factory AvailableSpacesRequestModel({
    required String dayOfWeek,
    required String startTime,
    required String endTime,
  }) = _AvailableSpacesRequestModel;

  factory AvailableSpacesRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableSpacesRequestModelFromJson(json);
}

@freezed
class AvailableSpacesResponseModel with _$AvailableSpacesResponseModel {
  const factory AvailableSpacesResponseModel({
    required String building,
    required String room,
    required String availableFrom,
    required String availableUntil,
    required int minutesAvailable,
  }) = _AvailableSpacesResponseModel;

  factory AvailableSpacesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableSpacesResponseModelFromJson(json);
}

