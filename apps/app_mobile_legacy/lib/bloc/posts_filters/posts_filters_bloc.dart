import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/errors_&_exceptions/http_exception.dart';
import 'package:my_app/models/blog_post_category.dart';
import 'package:my_app/services/blog_post_category_service.dart';

part 'posts_filters_event.dart';

part 'posts_filters_state.dart';

class PostsFiltersBloc extends Bloc<PostsFiltersEvent, PostsFiltersState> {
  final BlogPostCategoriesService categoriesService;

  PostsFiltersBloc(this.categoriesService) : super(const PostsFiltersState()) {
    on<PostsFiltersEvent>((event, emit) async {
      try {
        if (event is PostsFiltersFetchCategoriesEvent) {
          emit(state.copyWith(status: DefaultBlocStatusEnum.loading));

          final List<BlogPostCategory> categories = await categoriesService.index();

          emit(state.copyWith(categories: categories, status: DefaultBlocStatusEnum.loaded));
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
