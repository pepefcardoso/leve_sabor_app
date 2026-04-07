part of 'signup_bloc.dart';

@immutable
class SignupState {
  final DefaultBlocStatusEnum status;

  final String? error;

  const SignupState({
    this.status = DefaultBlocStatusEnum.initial,
    this.error,
  });

  SignupState copyWith({
    DefaultBlocStatusEnum? status,
    String? error,
  }) {
    return SignupState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
