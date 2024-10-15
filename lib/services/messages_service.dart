import 'dart:convert';

import 'package:madnolia/models/chat/message_model.dart';

import '../global/environment.dart';
import 'package:http/http.dart' as http;

class MessagesService {

  Future<List> getMatchMessages(String id, int page) async{
    try {
      final queryParameters = {
        'match': id,
        'skip': page,
      };
      final url = Uri.parse("${Environment.apiUrl}/messages/match?match=$id&skip=$page");

      final resp = await http.get(url);

      final jsonBody = jsonDecode(resp.body);

      final messages = jsonBody.map((e) => Message.fromJson(e)).toList();
      return messages;
    } catch (e) {
      return [];
    }
  }
}