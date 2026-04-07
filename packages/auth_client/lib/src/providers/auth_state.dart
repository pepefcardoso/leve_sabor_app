import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'auth_state.freezed.dart';

/// Represents the exhaustive authentication states.
@freezed
class AuthState with _$AuthState {
  const factory AuthState.authenticated(supabase.User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.error(String message) = _Error;
}