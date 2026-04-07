import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:auth_client/auth_client.dart';

class MockSupabaseClient extends Mock implements supabase.SupabaseClient {}
class MockGoTrueClient extends Mock implements supabase.GoTrueClient {}
class MockAuthResponse extends Mock implements supabase.AuthResponse {}

void main() {
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;
  late SupabaseAuthRepository repository;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    
    // Inject the mocked GoTrueClient (auth) into the Supabase client
    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
    
    repository = SupabaseAuthRepository(mockSupabaseClient);
  });

  group('SupabaseAuthRepository Tests', () {
    test('signIn calls signInWithPassword with correct parameters', () async {
      when(() => mockGoTrueClient.signInWithPassword(
            email: 'test@example.com',
            password: 'password123',
          )).thenAnswer((_) async => MockAuthResponse());

      await repository.signIn(email: 'test@example.com', password: 'password123');

      verify(() => mockGoTrueClient.signInWithPassword(
            email: 'test@example.com',
            password: 'password123',
          )).called(1);
    });

    test('signUp calls signUp with correct metadata', () async {
      final metadata = {'name': 'John Doe', 'cpf': '12345678900'};
      
      when(() => mockGoTrueClient.signUp(
            email: 'test@example.com',
            password: 'password123',
            data: metadata,
          )).thenAnswer((_) async => MockAuthResponse());

      await repository.signUp(
        email: 'test@example.com',
        password: 'password123',
        metadata: metadata,
      );

      verify(() => mockGoTrueClient.signUp(
            email: 'test@example.com',
            password: 'password123',
            data: metadata,
          )).called(1);
    });

    test('signOut calls auth.signOut', () async {
      when(() => mockGoTrueClient.signOut()).thenAnswer((_) async {});

      await repository.signOut();

      verify(() => mockGoTrueClient.signOut()).called(1);
    });
  });
}