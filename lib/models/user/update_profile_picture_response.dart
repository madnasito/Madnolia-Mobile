import 'dart:convert';

UpdateProfilePictureResponse updateProfilePictureResponseFromJson(String str) => UpdateProfilePictureResponse.fromJson(json.decode(str));

String updateProfilePictureResponseToJson(UpdateProfilePictureResponse data) => json.encode(data.toJson());

class UpdateProfilePictureResponse {
    String thumb;
    String image;

    UpdateProfilePictureResponse({
        required this.thumb,
        required this.image,
    });

    factory UpdateProfilePictureResponse.fromJson(Map<String, dynamic> json) => UpdateProfilePictureResponse(
        thumb: json["thumb"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "thumb": thumb,
        "image": image,
    };
}
