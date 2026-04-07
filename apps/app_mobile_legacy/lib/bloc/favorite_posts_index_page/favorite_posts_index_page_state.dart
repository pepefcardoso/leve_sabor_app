part of 'favorite_posts_index_page_bloc.dart';

@immutable
class FavoritePostsIndexPageState {
  final DefaultBlocStatusEnum status;
  final List<BlogPost> posts;
  final String? error;

  const FavoritePostsIndexPageState({
    this.status = DefaultBlocStatusEnum.initial,
    this.posts = const [],
    this.error,
  });

  FavoritePostsIndexPageState copyWith({
    DefaultBlocStatusEnum? status,
    List<BlogPost>? posts,
    String? error,
  }) {
    return FavoritePostsIndexPageState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}
