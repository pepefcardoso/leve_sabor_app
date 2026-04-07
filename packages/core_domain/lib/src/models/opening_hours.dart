import 'package:freezed_annotation/freezed_annotation.dart';

part 'opening_hours.freezed.dart';
part 'opening_hours.g.dart';

@freezed
class OpeningHours with _$OpeningHours {
  const factory OpeningHours({
    int? id,
    DateTime? specificDate,
    int? dayOfWeek,
    DateTime? openingTime,
    DateTime? closingTime,
    DateTime? openingTime2,
    DateTime? closingTime2,
    int? businessId,
  }) = _OpeningHours;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => _$OpeningHoursFromJson(json);
}