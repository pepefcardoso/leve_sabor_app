import 'package:test/test.dart';
import 'package:core_domain/core_domain.dart';

void main() {
  group('Core Domain Models Serialization & Logic', () {
    test('Business serialization', () {
      final json = {
        'id': 1,
        'name': 'Restaurante Teste',
        'open_now': true,
        'address': {
          'id': 10,
          'city': 'São Paulo',
        }
      };

      final business = Business.fromJson(json);
      expect(business.id, 1);
      expect(business.name, 'Restaurante Teste');
      expect(business.openNow, true);
      expect(business.address?.city, 'São Paulo');

      final serialized = business.toJson();
      expect(serialized['id'], 1);
      expect(serialized['name'], 'Restaurante Teste');
      expect(serialized['open_now'], true);
    });

    test('User logic (firstName)', () {
      final user = const User(id: 1, name: 'João Silva', email: 'joao@email.com');
      expect(user.firstName, 'João');
    });

    test('BlogPost logic (formattedCreatedAt)', () {
      final post = BlogPost(id: 1, title: 'Title', createdAt: DateTime(2023, 10, 20));
      expect(post.formattedCreatedAt, '20/10/2023');
    });
  });
}