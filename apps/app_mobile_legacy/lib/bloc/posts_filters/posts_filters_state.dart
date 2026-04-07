part of 'posts_filters_bloc.dart';

@immutable
class PostsFiltersState {
  final DefaultBlocStatusEnum status;
  final List<BlogPostCategory> categories;
  final String? error;

  const PostsFiltersState({
    this.status = DefaultBlocStatusEnum.initial,
    this.categories = const [],
    this.error,
  });

  PostsFiltersState copyWith({
    DefaultBlocStatusEnum? status,
    List<BlogPostCategory>? categories,
    String? error,
  }) {
    return PostsFiltersState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: error ?? this.error,
    );
  }
}
