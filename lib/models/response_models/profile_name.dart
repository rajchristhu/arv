import 'dart:convert';

class ProfileName {
  String profileName;

  ProfileName({
    required this.profileName,
  });

  factory ProfileName.fromRawJson(String str) => ProfileName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileName.fromJson(Map<String, dynamic> json) => ProfileName(
    profileName: json["profileName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "profileName": profileName,
      };
}
