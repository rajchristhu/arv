import 'dart:convert';

class ArvUser {
  String phone;
  String username;
  String uid;
  String userType;
  String email;

  ArvUser({
    required this.phone,
    required this.username,
    required this.uid,
    required this.userType,
    required this.email,
  });

  factory ArvUser.fromRawJson(String str) => ArvUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArvUser.fromJson(Map<String, dynamic> json) => ArvUser(
        phone: json["phone"],
        username: json["username"],
        uid: json["uid"],
        userType: json["userType"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "username": username,
        "uid": uid,
        "userType": userType,
        "email": email,
      };
}
