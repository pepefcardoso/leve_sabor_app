import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_image.freezed.dart';
part 'user_image.g.dart';

@freezed
class UserImage with _$UserImage {
  const factory UserImage({
    int? id,
    String? name,
    String? path,
    @JsonKey(name: 'user_id') int? userId,
    String? url,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _UserImage;

  factory UserImage.fromJson(Map<String, dynamic> json) => _$UserImageFromJson(json);
}