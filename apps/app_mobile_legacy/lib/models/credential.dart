class Credential {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;

  const Credential({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  Credential.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        tokenType = json['token_type'],
        expiresIn = json['expires_in'];
}
