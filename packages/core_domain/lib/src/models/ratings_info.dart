import 'package:freezed_annotation/freezed_annotation.dart';

part 'ratings_info.freezed.dart';
part 'ratings_info.g.dart';

@freezed
class RatingsInfo with _$RatingsInfo {
  const factory RatingsInfo({
    @JsonKey(name: 'total_reviews') int? count,
    @JsonKey(name: 'average_rating') double? average,
  }) = _RatingsInfo;

  factory RatingsInfo.fromJson(Map<String, dynamic> json) => _$RatingsInfoFromJson(json);
}