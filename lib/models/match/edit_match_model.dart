import 'dart:convert';

EditMatchModel editMatchModelFromJson(String str) => EditMatchModel.fromJson(json.decode(str));

String editMatchModelToJson(EditMatchModel data) => json.encode(data.toJson());

class EditMatchModel {
    String title;
    String description;
    int date;

    EditMatchModel({
        required this.title,
        required this.description,
        required this.date,
    });

    factory EditMatchModel.fromJson(Map<String, dynamic> json) => EditMatchModel(
        title: json["title"],
        description: json["description"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "date": date,
    };
}
