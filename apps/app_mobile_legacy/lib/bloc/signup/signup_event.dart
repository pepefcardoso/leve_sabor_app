part of 'signup_bloc.dart';

abstract class SignupEvent {
  const SignupEvent();
}

class RequestSignup extends SignupEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  const RequestSignup({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}
