part of 'business_index_bloc.dart';

abstract class BusinessIndexEvent {
  const BusinessIndexEvent();
}

class RequestBusinesses extends BusinessIndexEvent {
  final Map<String, dynamic>? queryParameters;

  const RequestBusinesses({this.queryParameters});
}
