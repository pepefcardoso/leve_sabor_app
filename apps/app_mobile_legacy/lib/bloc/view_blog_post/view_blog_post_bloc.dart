import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/errors_&_exceptions/http_exception.dart';
import 'package:my_app/models/blog_post.dart';
import 'package:my_app/services/blog_posts_service.dart';

part 'view_blog_post_event.dart';

part 'view_blog_post_state.dart';

class ViewBlogPostBloc extends Bloc<ViewBlogPostEvent, ViewBlogPostState> {
  final BlogPostsService blogPostsService;

  ViewBlogPostBloc({required this.blogPostsService}) : super(const ViewBlogPostState()) {
    on<ViewBlogPostEvent>((event, emit) async {
      try {
        if (event is RequestBlogPost) {
          emit(state.copyWith(status: DefaultBlocStatusEnum.loading));

          final BlogPost blogPost = await blogPostsService.show(event.id);

          emit(state.copyWith(blogPost: blogPost, status: DefaultBlocStatusEnum.loaded));
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
