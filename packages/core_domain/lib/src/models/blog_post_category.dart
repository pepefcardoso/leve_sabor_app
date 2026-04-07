import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_post_category.freezed.dart';
part 'blog_post_category.g.dart';

@freezed
class BlogPostCategory with _$BlogPostCategory {
  const factory BlogPostCategory({
    int? id,
    String? name,
  }) = _BlogPostCategory;

  factory BlogPostCategory.fromJson(Map<String, dynamic> json) => _$BlogPostCategoryFromJson(json);
}