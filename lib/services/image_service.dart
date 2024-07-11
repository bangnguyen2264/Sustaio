import 'dart:convert';
import 'dart:io';

import 'package:gdsc_2024/services/api_service.dart';
import 'package:gdsc_2024/services/global.dart';
import 'package:http/http.dart' as http;

class ImageService {
  Future<String?> uploadImage(File image) async {
    String? token = await getSavedToken();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/image'),
        headers: {
          'accept': '*/*',
          'Authorization': '$token',
          'Content-Type': 'multipart/form-data'
              'image=@ex image.jpg;type=image/jpeg',
        },
        body: jsonEncode(image),
      );
      print('Status code: ${response.statusCode}, Response: ${response.body}');
      if (response.statusCode == 200) {
        // Successful POST request
        print('POST request successful');
        print('Response: ${response.body}');
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        String imageUrl = responseBody['imageUrl'];

        return imageUrl;
      } else {
        throw Exception(
            'Failed to make POST image request. Status code: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (error) {
      print('Error during POST image request: $error ');
      // Handle the error as needed
    }
  }
}
