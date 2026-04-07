import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:my_app/models/business.dart';
import 'package:my_app/services/business_service.dart';

part 'business_index_event.dart';

part 'business_index_state.dart';

class BusinessIndexBloc extends Bloc<BusinessIndexEvent, BusinessIndexState> {
  final BusinessService businessService;

  BusinessIndexBloc(this.businessService) : super(const BusinessIndexState()) {
    on<BusinessIndexEvent>((event, emit) async {
      try {
        if (event is RequestBusinesses) {
          emit(state.copyWith(status: BusinessIndexStatus.loading));

          final Map<String, dynamic> data = await businessService.getBusinesses(event.queryParameters);

          final List<Business> businesses = data['businesses'];

          final int count = data['count'];

          emit(state.copyWith(businesses: businesses, count: count, status: BusinessIndexStatus.loaded));
        }
      } catch (e) {
        emit(state.copyWith(error: e.toString(), status: BusinessIndexStatus.error));
      }
    });
  }
}
