import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth_repository.dart';
import '../supabase_auth_repository.dart';
import 'auth_state.dart';

part 'auth_providers.g.dart';

/// Provides the Supabase client instance.
/// Assumes Supabase.initialize() has been called in the app's main().
@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

/// Provides the implementation of the AuthRepository.
@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAuthRepository(client);
}

/// Listens to Supabase Auth state changes and maps them to [AuthState].
@riverpod
Stream<AuthState> authState(AuthStateRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  
  return supabase.auth.onAuthStateChange.map((data) {
    final session = data.session;
    if (session != null && session.user != null) {
      return AuthState.authenticated(session.user!);
    }
    return const AuthState.unauthenticated();
  }).handleError((error) {
    return AuthState.error(error.toString());
  });
}