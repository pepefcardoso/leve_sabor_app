import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/errors_&_exceptions/http_exception.dart';
import 'package:my_app/services/blog_posts_service.dart';

part 'favorite_post_button_event.dart';

part 'favorite_post_button_state.dart';

class FavoritePostButtonBloc extends Bloc<FavoritePostButtonEvent, FavoritePostButtonState> {
  final BlogPostsService blogPostsService;
  final bool isFavorite;
  final int postId;

  FavoritePostButtonBloc({
    required this.blogPostsService,
    required this.isFavorite,
    required this.postId,
  }) : super(FavoritePostButtonState(isFavorite: isFavorite)) {
    on<FavoritePostButtonEvent>((event, emit) async {
      try {
        if (event is RequestFavoriteBlogPost) {
          emit(state.copyWith(status: DefaultBlocStatusEnum.loading));

          final bool isFavorite = await blogPostsService.favorite(postId);

          emit(state.copyWith(isFavorite: isFavorite, status: DefaultBlocStatusEnum.loaded));
        } else if (event is RequestUnfavoriteBlogPost) {
          emit(state.copyWith(status: DefaultBlocStatusEnum.loading));

          final bool isFavorite = await blogPostsService.unfavorite(postId);

          emit(state.copyWith(isFavorite: isFavorite, status: DefaultBlocStatusEnum.loaded));
        }
      } on HttpException catch (httpException) {
        log(httpException.mensagem);

        emit(state.copyWith(error: httpException.mensagem, status: DefaultBlocStatusEnum.error));
      } catch (e) {
        log(e.toString());

        emit(state.copyWith(error: e.toString(), status: DefaultBlocStatusEnum.error));
      }
    });
  }
}
