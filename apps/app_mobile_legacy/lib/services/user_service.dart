import 'package:my_app/utils/http.dart';

class UserService {
  final Http http;

  UserService({required this.http});

  Future<String> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await http.postJson(
      '/api/register',
      dados: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    );

    final Map<String, dynamic> data = response.data;

    return data['token'];
  }
}
