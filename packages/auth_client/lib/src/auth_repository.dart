import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Abstract interface for authentication operations to enforce Clean Architecture.
abstract class AuthRepository {
  /// Signs in a user with their email and password.
  Future<void> signIn({
    required String email,
    required String password,
  });

  /// Signs up a new user, optionally accepting additional user metadata.
  Future<void> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  });

  /// Signs the user out.
  Future<void> signOut();

  /// Retrieves the currently authenticated user synchronously, if any.
  supabase.User? get currentUser;
}