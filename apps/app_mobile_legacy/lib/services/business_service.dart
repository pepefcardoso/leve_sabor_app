import 'package:my_app/models/business.dart';
import 'package:my_app/utils/http.dart';

class BusinessService {
  final Http http;

  BusinessService({required this.http});

  Future<Map<String, dynamic>> getBusinesses(Map<String, dynamic>? filters) async {
    final response = await http.getJson(
      '/api/businesses',
      queryParameters: filters,
    );

    final Map<String, dynamic> data = response.data;

    final List<Business> businesses = (data['items'] as List).map<Business>((item) => Business.fromJson(item)).toList();

    final int count = data['count'];

    return {
      'businesses': businesses,
      'count': count,
    };
  }
}
