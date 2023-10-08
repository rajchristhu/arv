import 'dart:convert';

class ResponseMessage {
    String message;

    ResponseMessage({
        required this.message,
    });

    factory ResponseMessage.fromRawJson(String str) => ResponseMessage.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResponseMessage.fromJson(Map<String, dynamic> json) => ResponseMessage(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
