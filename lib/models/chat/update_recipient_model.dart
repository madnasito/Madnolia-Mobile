// To parse this JSON data, do
//
//     final updateRecipientModel = updateRecipientModelFromJson(jsonString);

import 'dart:convert';

import '../../enums/chat_message_status.enum.dart';

UpdateRecipientModel updateRecipientModelFromJson(String str) => UpdateRecipientModel.fromJson(json.decode(str));

String updateRecipientModelToJson(UpdateRecipientModel data) => json.encode(data.toJson());

class UpdateRecipientModel {
    String id;
    ChatMessageStatus status;

    UpdateRecipientModel({
        required this.id,
        required this.status,
    });

    factory UpdateRecipientModel.fromJson(Map<String, dynamic> json) => UpdateRecipientModel(
        id: json["id"],
        status: ChatMessageStatus.values.firstWhere((e) => e == json["status"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status.index,
    };
}
