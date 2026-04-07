part of 'home_page_bloc.dart';

@immutable
class HomePageState {
  final DefaultBlocStatusEnum status;
  final String? error;

  const HomePageState({
    this.status = DefaultBlocStatusEnum.initial,
    this.error,
  });

  HomePageState copyWith({
    DefaultBlocStatusEnum? status,
    String? error,
  }) {
    return HomePageState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
