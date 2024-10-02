// To parse this JSON data, do
//
//     final updateUser = updateUserFromJson(jsonString);

import 'dart:convert';

UpdateUser updateUserFromJson(String str) => UpdateUser.fromJson(json.decode(str));

String updateUserToJson(UpdateUser data) => json.encode(data.toJson());

class UpdateUser {
    String name;
    String username;
    String email;
    int availability;

    UpdateUser({
        required this.name,
        required this.username,
        required this.email,
        required this.availability,
    });

    factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        availability: json["availability"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "availability": availability,
    };
}
