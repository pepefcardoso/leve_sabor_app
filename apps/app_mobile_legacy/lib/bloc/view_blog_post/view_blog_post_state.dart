part of 'view_blog_post_bloc.dart';

@immutable
class ViewBlogPostState {
  final DefaultBlocStatusEnum status;
  final BlogPost? blogPost;
  final String? error;

  const ViewBlogPostState({
    this.status = DefaultBlocStatusEnum.initial,
    this.blogPost,
    this.error,
  });

  ViewBlogPostState copyWith({
    DefaultBlocStatusEnum? status,
    BlogPost? blogPost,
    String? error,
  }) {
    return ViewBlogPostState(
      status: status ?? this.status,
      blogPost: blogPost ?? this.blogPost,
      error: error ?? this.error,
    );
  }
}
