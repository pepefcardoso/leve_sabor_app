import 'package:my_app/enum/blog_post_status_enum.dart';
import 'package:my_app/models/blog_post_category.dart';
import 'package:my_app/models/blog_post_image.dart';
import 'package:my_app/models/user.dart';
import 'package:intl/intl.dart';

class BlogPost {
  final int? id;
  final String? title;
  final String? description;
  final String? content;
  final BlogPostStatusEnum? status;
  final User? user;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<BlogPostCategory>? categories;
  final BlogPostImage? image;
  final bool? isFavorite;

  BlogPost({
    this.id,
    this.title,
    this.description,
    this.content,
    this.image,
    this.status,
    this.categories,
    this.user,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.isFavorite,
  });

  BlogPost.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        content = json['content'],
        image = json['blog_post_image'] != null ? BlogPostImage.fromJson(json['blog_post_image']) : null,
        status = json['status'] != null ? BlogPostStatusEnum.values.firstWhere((element) => element.value == json['status']) : null,
        categories = json['categories'] != null ? (json['categories'] as List).map((tag) => BlogPostCategory.fromJson(tag)).toList() : null,
        user = json['user'] != null ? User.fromJson(json['user']) : null,
        userId = json['user_id'],
        createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
        updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
        isFavorite = json['favorite'];

  String? get formattedCreatedAt => createdAt != null ? DateFormat('dd/MM/yyyy').format(createdAt!) : null;
}
