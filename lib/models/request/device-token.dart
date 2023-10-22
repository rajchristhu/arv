import 'dart:convert';

class DeviceToken {
  String username;
  String deviceToken;

  DeviceToken({
    required this.username,
    required this.deviceToken,
  });

  factory DeviceToken.fromRawJson(String str) =>
      DeviceToken.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeviceToken.fromJson(Map<String, dynamic> json) => DeviceToken(
        username: json["username"],
        deviceToken: json["deviceToken"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "deviceToken": deviceToken,
      };
}
