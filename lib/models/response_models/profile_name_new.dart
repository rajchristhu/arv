import 'dart:convert';

class ProfileNameNew {
  String username;

  ProfileNameNew({
    this.username = "",
  });

  factory ProfileNameNew.fromRawJson(String str) =>
      ProfileNameNew.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileNameNew.fromJson(Map<String, dynamic> json) => ProfileNameNew(
    username: json["username"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
