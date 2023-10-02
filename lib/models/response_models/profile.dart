import 'dart:convert';

class Profile {
  String id;
  String phone;
  String? email;
  String? profileName;
  dynamic profileImage;

  Profile({
    required this.id,
    required this.phone,
    required this.email,
    required this.profileName,
    required this.profileImage,
  });

  factory Profile.fromRawJson(String str) => Profile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"] ?? "",
        phone: json["phone"] ?? "",
        email: json["email"],
        profileName: json["profileName"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "profileName": profileName,
        "profileImage": profileImage,
      };
}
