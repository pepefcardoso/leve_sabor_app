import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_app/bloc/login/login_bloc.dart';
import 'package:my_app/enum/default_bloc_status_enum.dart';
import 'package:my_app/errors_&_exceptions/http_exception.dart';
import 'package:my_app/services/user_service.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserService userService;
  final LoginBloc loginBloc;

  SignupBloc({
    required this.userService,
    required this.loginBloc,
  }) : super(const SignupState()) {
    on<SignupEvent>((event, emit) async {
      try {
        if (event is RequestSignup) {
          emit(state.copyWith(status: DefaultBlocStatusEnum.loading));

          await userService.register(
            name: event.name,
            email: event.email,
            phone: event.phone,
            password: event.password,
          );

          loginBloc.add(RequestLogin(
            email: event.email,
            password: event.password,
          ));

          emit(state.copyWith(status: DefaultBlocStatusEnum.loaded));
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
