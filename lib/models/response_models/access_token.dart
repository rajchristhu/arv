import 'dart:convert';

class AccessToken {
  String token;

  AccessToken({
    required this.token,
  });

  factory AccessToken.fromRawJson(String str) =>
      AccessToken.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccessToken.fromJson(Map<String, dynamic> json) => AccessToken(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
