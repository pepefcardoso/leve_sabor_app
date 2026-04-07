import 'dart:io';

import 'package:my_app/models/blog_post.dart';
import 'package:my_app/utils/http.dart';

class BlogPostsService {
  final Http http;

  BlogPostsService({required this.http});

  Future<List<BlogPost>> index({Map<String, dynamic>? parameters}) async {
    final response = await http.getJson(
      '/api/blog-posts',
      queryParameters: parameters,
    );

    final List<dynamic>? data = response.data;

    if (data != null) {
      final List<BlogPost> blogPosts = data.map((dynamic json) => BlogPost.fromJson(json)).toList();

      return blogPosts;
    } else {
      throw const HttpException('Erro desconhecido');
    }
  }

  Future<List<BlogPost>> favoritesIndex({Map<String, dynamic>? parameters}) async {
    final response = await http.getJson(
      '/api/blog-posts/favorites',
      queryParameters: parameters,
    );

    final Map<String, dynamic>? data = response.data;
    final List<dynamic>? items = data?['original'];

    if (items != null) {
      final List<BlogPost> blogPosts = items.map((dynamic json) => BlogPost.fromJson(json)).toList();

      return blogPosts;
    } else {
      throw const HttpException('Erro desconhecido');
    }
  }

  Future<BlogPost> show(int id) async {
    final response = await http.getJson('/api/blog-posts/$id');

    final dynamic data = response.data;

    if (data != null) {
      return BlogPost.fromJson(data);
    } else {
      throw const HttpException('Erro desconhecido');
    }
  }

  Future<bool> favorite(int id) async {
    final response = await http.postJson('/api/blog-posts/favorites/$id');

    final dynamic data = response.data;

    if (data != null) {
      return data;
    } else {
      throw const HttpException('Erro desconhecido');
    }
  }

  Future<bool> unfavorite(int id) async {
    final response = await http.deleteJson('/api/blog-posts/favorites/$id');

    final dynamic data = response.data;

    if (data != null) {
      return data;
    } else {
      throw const HttpException('Erro desconhecido');
    }
  }
}
