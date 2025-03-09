// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    String name;
    String username;
    String email;
    String password;
    List<int> platforms;

    RegisterModel({
        required this.name,
        required this.username,
        required this.email,
        required this.password,
        required this.platforms,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        platforms: List<int>.from(json["platforms"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "password": password,
        "platforms": List<dynamic>.from(platforms.map((x) => x)),
    };
}
