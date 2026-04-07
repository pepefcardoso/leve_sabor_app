import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../enums/blog_post_status_enum.dart';
import 'blog_post_category.dart';
import 'blog_post_image.dart';
import 'user.dart';

part 'blog_post.freezed.dart';
part 'blog_post.g.dart';

@freezed
class BlogPost with _$BlogPost {
  const BlogPost._();

  const factory BlogPost({
    int? id,
    String? title,
    String? description,
    String? content,
    @JsonKey(name: 'blog_post_image') BlogPostImage? image,
    BlogPostStatusEnum? status,
    List<BlogPostCategory>? categories,
    User? user,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'favorite') bool? isFavorite,
  }) = _BlogPost;

  factory BlogPost.fromJson(Map<String, dynamic> json) => _$BlogPostFromJson(json);

  String? get formattedCreatedAt => 
      createdAt != null ? DateFormat('dd/MM/yyyy').format(createdAt!) : null;
}