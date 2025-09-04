import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart' as http;
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mime_type/mime_type.dart';

class UploadFileService {
  final storage = const FlutterSecureStorage();

  Future uploadImage(String path) async {
    try {
      
      final String apiUrl = dotenv.get("API_URL");
      
      final String? token = await storage.read(key: "token");
      final url = Uri.parse("$apiUrl/user/update-img");

      final mimeType = mime(path)?.split('/'); // image/jpeg


      final imageUploadRequest = http.MultipartRequest("POST", url);

      final file = await http.MultipartFile.fromPath("img", path,
          contentType: http.MediaType(mimeType![0], mimeType[1]));

      imageUploadRequest.files.add(file);
      imageUploadRequest.headers.addAll({
        "Authorization": "Bearer $token"
      });

      final streamResponse = await imageUploadRequest.send();

      final resp = await http.Response.fromStream(streamResponse);

      return jsonDecode(resp.body);
    } catch (e) {
      return {"message": "NETWORK_ERROR", "error": "Network error"};
    }
  }
}
