import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String name;
  String email;
  String? password;
  String username;
  String? acceptInvitations;
  List<int> platforms;
  String? img;
  String? thumbImg;
  String? id;

  User(
      {required this.name,
      required this.email,
      this.password,
      required this.username,
      this.acceptInvitations,
      required this.platforms,
      this.img,
      this.thumbImg,
      this.id});

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json["name"],
      email: json["email"],
      password: json["password"],
      username: json["username"],
      acceptInvitations: json["accept_invitations"],
      platforms: List<int>.from(json["platforms"].map((x) => x)),
      img: json["img"],
      thumbImg: json["thumb_img"],
      id: json["uid"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "username": username,
        "accept_invitations": acceptInvitations,
        "platforms": List<dynamic>.from(platforms.map((x) => x)),
        "img": img,
        "thumb_img": thumbImg,
        "_id": id
      };
}
