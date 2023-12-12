import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart' as http;
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:madnolia/global/environment.dart';
import 'package:mime_type/mime_type.dart';

class UploadFileService {
  final storage = const FlutterSecureStorage();

  Future uploadImage(XFile image) async {
    try {
      final url = Uri.parse("${Environment.apiUrl}/upload/users");

      final mimeType = mime(image.path)?.split('/'); // image/jpeg

      String? token = await storage.read(key: "token");

      final imageUploadRequest = http.MultipartRequest("PUT", url)
        ..headers["token"] = token.toString();

      final file = await http.MultipartFile.fromPath("img", image.path,
          contentType: http.MediaType(mimeType![0], mimeType[1]));

      imageUploadRequest.files.add(file);

      final streamResponse = await imageUploadRequest.send();

      final resp = await http.Response.fromStream(streamResponse);

      return jsonDecode(resp.body);
    } catch (e) {
      return {"ok": false, "err": "Network error"};
    }
  }
}
