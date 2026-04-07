part of 'favorite_post_button_bloc.dart';

abstract class FavoritePostButtonEvent {
  const FavoritePostButtonEvent();
}

class RequestFavoriteBlogPost extends FavoritePostButtonEvent {
  const RequestFavoriteBlogPost();
}

class RequestUnfavoriteBlogPost extends FavoritePostButtonEvent {
  const RequestUnfavoriteBlogPost();
}
