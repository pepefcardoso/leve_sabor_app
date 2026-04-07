import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'auth_repository.dart';

/// Concrete implementation of [AuthRepository] using the Supabase SDK.
class SupabaseAuthRepository implements AuthRepository {
  final supabase.SupabaseClient _supabaseClient;

  SupabaseAuthRepository(this._supabaseClient);

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: metadata,
    );
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  @override
  supabase.User? get currentUser => _supabaseClient.auth.currentUser;
}