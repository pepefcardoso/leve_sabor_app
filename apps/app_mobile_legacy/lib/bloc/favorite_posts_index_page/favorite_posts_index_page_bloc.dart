import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/errors_&_exceptions/http_exception.dart';
import 'package:my_app/models/blog_post.dart';
import 'package:my_app/services/blog_posts_service.dart';

part 'favorite_posts_index_page_event.dart';

part 'favorite_posts_index_page_state.dart';

class FavoritePostsIndexPageBloc extends Bloc<FavoritePostsIndexPageEvent, FavoritePostsIndexPageState> {
  final BlogPostsService service;

  FavoritePostsIndexPageBloc(this.service) : super(const FavoritePostsIndexPageState()) {
    on<FavoritePostsIndexPageEvent>((event, emit) async {
      try {
        if (event is RequestFavoritePosts) {
          emit(state.copyWith(status: DefaultBlocStatusEnum.loading));

          final List<BlogPost> posts = await service.favoritesIndex();

          emit(state.copyWith(posts: posts, status: DefaultBlocStatusEnum.loaded));
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
