import 'package:my_app/errors_&_exceptions/http_exception.dart';
import 'package:my_app/models/blog_post_category.dart';
import 'package:my_app/utils/http.dart';

class BlogPostCategoriesService {
  final Http http;

  BlogPostCategoriesService({required this.http});

  Future<List<BlogPostCategory>> index() async {
    final response = await http.getJson('/api/blog-post-category');

    final List<dynamic>? data = response.data;

    if (data != null) {
      return data.map((dynamic json) => BlogPostCategory.fromJson(json)).toList();
    } else {
      throw const HttpException('Erro desconhecido');
    }
  }
}
