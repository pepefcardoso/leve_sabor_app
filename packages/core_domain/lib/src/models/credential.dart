import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential.freezed.dart';
part 'credential.g.dart';

@freezed
class Credential with _$Credential {
  const factory Credential({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'token_type') String? tokenType,
    @JsonKey(name: 'expires_in') int? expiresIn,
  }) = _Credential;

  factory Credential.fromJson(Map<String, dynamic> json) => _$CredentialFromJson(json);
}