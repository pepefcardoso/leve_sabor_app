import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/errors_&_exceptions/http_exception.dart';
import 'package:my_app/models/blog_post.dart';
import 'package:my_app/services/blog_posts_service.dart';

part 'home_blog_page_event.dart';

part 'home_blog_page_state.dart';

class HomeBlogPageBloc extends Bloc<HomeBlogPageEvent, HomeBlogPageState> {
  final BlogPostsService service;

  HomeBlogPageBloc(this.service) : super(const HomeBlogPageState()) {
    on<HomeBlogPageEvent>((event, emit) async {
      try {
        if (event is RequestPosts) {
          emit(state.copyWith(status: DefaultBlocStatusEnum.loading));

          final List<BlogPost> posts = await service.index();

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
