part of 'search_posts_page_bloc.dart';

@immutable
class SearchPostsPageState {
  final DefaultBlocStatusEnum status;
  final List<BlogPost> posts;
  final String? error;

  const SearchPostsPageState({
    this.status = DefaultBlocStatusEnum.initial,
    this.posts = const [],
    this.error,
  });

  SearchPostsPageState copyWith({
    DefaultBlocStatusEnum? status,
    List<BlogPost>? posts,
    String? error,
  }) {
    return SearchPostsPageState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}
