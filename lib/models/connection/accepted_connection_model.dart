import 'dart:convert';

import 'package:madnolia/models/friendship/connection_request.dart';
import 'package:madnolia/models/friendship/friendship_model.dart';

AcceptedConnection acceptedConnectionFromJson(String str) =>
    AcceptedConnection.fromJson(json.decode(str));

String acceptedConnectionToJson(AcceptedConnection data) =>
    json.encode(data.toJson());

class AcceptedConnection {
  final Friendship friendship;
  final ConnectionRequest request;

  AcceptedConnection({required this.friendship, required this.request});

  factory AcceptedConnection.fromJson(Map<String, dynamic> json) {
    return AcceptedConnection(
      friendship: Friendship.fromJson(json['friendship']),
      request: ConnectionRequest.fromJson(json['request']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'friendship': friendship.toJson(), 'request': request.toJson()};
  }
}
