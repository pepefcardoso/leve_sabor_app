import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/errors_&_exceptions/http_exception.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(const HomePageState()) {
    on<HomePageEvent>((event, emit) async {
      try {} on HttpException catch (httpException) {
        log(httpException.mensagem);

        emit(state.copyWith(error: httpException.mensagem, status: DefaultBlocStatusEnum.error));
      } catch (e) {
        log(e.toString());

        emit(state.copyWith(error: e.toString(), status: DefaultBlocStatusEnum.error));
      }
    });
  }
}
