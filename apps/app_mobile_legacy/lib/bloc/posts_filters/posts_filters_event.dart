part of 'posts_filters_bloc.dart';

abstract class PostsFiltersEvent {
  const PostsFiltersEvent();
}

class PostsFiltersFetchCategoriesEvent extends PostsFiltersEvent {
  const PostsFiltersFetchCategoriesEvent();
}
