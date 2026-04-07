part of 'business_index_bloc.dart';

enum BusinessIndexStatus { initial, loading, loaded, error }

@immutable
class BusinessIndexState {
  final List<Business> businesses;
  final int count;
  final BusinessIndexStatus status;
  final String? error;

  const BusinessIndexState({
    this.businesses = const [],
    this.count = 0,
    this.status = BusinessIndexStatus.initial,
    this.error,
  });

  BusinessIndexState copyWith({
    List<Business>? businesses,
    int? count,
    BusinessIndexStatus? status,
    String? error,
  }) {
    return BusinessIndexState(
      businesses: businesses ?? this.businesses,
      count: count ?? this.count,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
