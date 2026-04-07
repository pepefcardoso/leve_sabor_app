part of 'view_blog_post_bloc.dart';

abstract class ViewBlogPostEvent {
  const ViewBlogPostEvent();
}

class RequestBlogPost extends ViewBlogPostEvent {
  final int id;

  const RequestBlogPost({
    required this.id,
  });
}
