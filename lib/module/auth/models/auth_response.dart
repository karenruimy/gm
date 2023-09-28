

class TokenResponse {
  String tokenType;
  int iat;
  int expiresIn;
  String jwtToken;

  TokenResponse({
    required this.tokenType,
    required this.iat,
    required this.expiresIn,
    required this.jwtToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
    tokenType: json["token_type"],
    iat: json["iat"],
    expiresIn: json["expires_in"],
    jwtToken: json["jwt_token"],
  );

  Map<String, dynamic> toJson() => {
    "token_type": tokenType,
    "iat": iat,
    "expires_in": expiresIn,
    "jwt_token": jwtToken,
  };
}
