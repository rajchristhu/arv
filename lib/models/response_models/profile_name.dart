import 'dart:convert';

class ProfileName {
  String username;
  String profileName;

  ProfileName({
    required this.username,
    this.profileName = "",
  });

  factory ProfileName.fromRawJson(String str) =>
      ProfileName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileName.fromJson(Map<String, dynamic> json) => ProfileName(
        username: json["username"] ?? "",
        profileName: json["profileName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
