import 'dart:convert';

class ProfileName {
  String phone;
  String profileName;

  ProfileName({
    required this.phone,
    this.profileName = "",
  });

  factory ProfileName.fromRawJson(String str) =>
      ProfileName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileName.fromJson(Map<String, dynamic> json) => ProfileName(
    phone: json["phone"] ?? "",
        profileName: json["profileName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "profileName": profileName,
      };
}
