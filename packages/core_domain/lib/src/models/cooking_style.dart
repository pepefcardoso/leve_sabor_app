import 'package:freezed_annotation/freezed_annotation.dart';

part 'cooking_style.freezed.dart';
part 'cooking_style.g.dart';

@freezed
class CookingStyle with _$CookingStyle {
  const factory CookingStyle({
    int? id,
    String? name,
  }) = _CookingStyle;

  factory CookingStyle.fromJson(Map<String, dynamic> json) => _$CookingStyleFromJson(json);
}