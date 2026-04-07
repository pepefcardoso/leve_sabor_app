import 'package:freezed_annotation/freezed_annotation.dart';

import 'address.dart';
import 'category.dart';
import 'contact.dart';
import 'cooking_style.dart';
import 'diet.dart';
import 'image.dart';
import 'opening_hours.dart';
import 'ratings_info.dart';

part 'business.freezed.dart';
part 'business.g.dart';

@freezed
class Business with _$Business {
  const factory Business({
    int? id,
    String? name,
    String? description,
    Category? category,
    List<Diet>? diets,
    Address? address,
    Contact? contact,
    @JsonKey(name: 'opening_hours') List<OpeningHours>? openingHours,
    @JsonKey(name: 'cooking_styles') List<CookingStyle>? cookingStyles,
    List<Image>? images,
    bool? favorite,
    @JsonKey(name: 'open_now') bool? openNow,
    @JsonKey(name: 'logo_url') String? logoUrl,
    @JsonKey(name: 'ratings_info') RatingsInfo? ratingsInfo,
    @JsonKey(name: 'user_id') int? userId,
  }) = _Business;

  factory Business.fromJson(Map<String, dynamic> json) => _$BusinessFromJson(json);
}