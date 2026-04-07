import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_post_image.freezed.dart';
part 'blog_post_image.g.dart';

@freezed
class BlogPostImage with _$BlogPostImage {
  const factory BlogPostImage({
    int? id,
    String? name,
    String? path,
    @JsonKey(name: 'blog_post_id') int? blogPostId,
    String? url,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _BlogPostImage;

  factory BlogPostImage.fromJson(Map<String, dynamic> json) => _$BlogPostImageFromJson(json);
}