import 'dart:convert';

class ProfileName {
  String usename;

  ProfileName({
    required this.usename,
  });

  factory ProfileName.fromRawJson(String str) => ProfileName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileName.fromJson(Map<String, dynamic> json) => ProfileName(
    usename: json["usename"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "usename": usename,
      };
}
