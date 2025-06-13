// To parse this JSON data, do
//
//     final updateUser = updateUserFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/enums/user-availability.enum.dart';

UpdateUser updateUserFromJson(String str) => UpdateUser.fromJson(json.decode(str));

String updateUserToJson(UpdateUser data) => json.encode(data.toJson());

class UpdateUser {
    String name;
    String username;
    String email;
    UserAvailability availability;

    UpdateUser({
        required this.name,
        required this.username,
        required this.email,
        required this.availability,
    });

    factory UpdateUser.fromJson(Map<String, dynamic> json) {

      final UserAvailability availability;

      switch (json['availability']) {
        case 0:
          availability = UserAvailability.everyone;
          break;
        case 1:
          availability = UserAvailability.partners;
          break;
        case 2:
          availability = UserAvailability.no;
          break;
        default:
          availability = UserAvailability.everyone;
      }

      return UpdateUser(
        name: json["name"],
        username: json["username"],
        email: json["email"],
        availability: availability,
    );
    } 

    Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "email": email,
        "availability": availability.index,
    };
}
