part of 'favorite_post_button_bloc.dart';

@immutable
class FavoritePostButtonState {
  final DefaultBlocStatusEnum status;
  final bool? isFavorite;
  final String? error;

  const FavoritePostButtonState({
    this.status = DefaultBlocStatusEnum.initial,
    this.isFavorite,
    this.error,
  });

  FavoritePostButtonState copyWith({
    DefaultBlocStatusEnum? status,
    bool? isFavorite,
    String? error,
  }) {
    return FavoritePostButtonState(
      status: status ?? this.status,
      isFavorite: isFavorite ?? this.isFavorite,
      error: error ?? this.error,
    );
  }
}
