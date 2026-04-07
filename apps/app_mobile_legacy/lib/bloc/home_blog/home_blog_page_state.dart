part of 'home_blog_page_bloc.dart';

@immutable
class HomeBlogPageState {
  final DefaultBlocStatusEnum status;
  final List<BlogPost> posts;
  final String? error;

  const HomeBlogPageState({
    this.status = DefaultBlocStatusEnum.initial,
    this.posts = const [],
    this.error,
  });

  HomeBlogPageState copyWith({
    DefaultBlocStatusEnum? status,
    List<BlogPost>? posts,
    String? error,
  }) {
    return HomeBlogPageState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}
