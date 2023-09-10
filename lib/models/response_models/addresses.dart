import 'dart:convert';


class Addresses {
    List<Address> addresses;

    Addresses({
        required this.addresses,
    });

    factory Addresses.fromRawJson(String str) => Addresses.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Addresses.fromJson(Map<String, dynamic> json) => Addresses(
        addresses: List<Address>.from(json["Addresses"].map((x) => Address.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
    };
}

class Address {
    String? id;
    String name;
    String phone;
    String addressLine1;
    String addressLine2;
    String area;
    String pinCode;
    String state;
    String nation;
    String landMark;
    bool isDeliveryAddress;

    Address({
        this.id,
        required this.name,
        required this.phone,
        required this.addressLine1,
        required this.addressLine2,
        required this.area,
        required this.pinCode,
        required this.state,
        required this.nation,
        required this.landMark,
        required this.isDeliveryAddress,
    });

    factory Address.fromRawJson(String str) =>
        Address.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Address.fromJson(Map<String, dynamic> json) =>
        Address(
            id: json["id"],
            name: json["name"],
            phone: json["phone"],
            addressLine1: json["addressLine1"],
            addressLine2: json["addressLine2"],
            area: json["area"],
            pinCode: json["pinCode"],
            state: json["state"],
            nation: json["nation"],
            landMark: json["landMark"],
            isDeliveryAddress: json["isDeliveryAddress"],
        );

    Map<String, dynamic> toJson() =>
        {
            "id": id,
            "name": name,
            "phone": phone,
            "addressLine1": addressLine1,
            "addressLine2": addressLine2,
            "area": area,
            "pinCode": pinCode,
            "state": state,
            "nation": nation,
            "landMark": landMark,
            "isDeliveryAddress": isDeliveryAddress,
        };
}
