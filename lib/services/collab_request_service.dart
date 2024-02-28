import 'dart:convert';

import 'package:gdsc_2024/model/collab_request_dto.dart';
import 'package:gdsc_2024/services/api_service.dart';
import 'package:gdsc_2024/services/global.dart';
import 'package:http/http.dart' as http;

class CollabRequestService {
  Future<void> postCollabRequest(Map<String, dynamic> requestData) async {
    String? token = await getSavedToken();
    try {
      print(jsonEncode(requestData));
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/collab-requests'),
        headers: {
          'Authorization': '$token',
          'accept': '*/*',
          'Content-Type': 'application/json',
          'charset': 'utf-8',
        },
        body: jsonEncode(requestData),
      );
      if (response.statusCode == 200) {
        // Successful POST request
        print('POST request successful');
        print('Response: ${response.body}');
      } else {
        print(response.headers);
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception(
            'Failed to make POST request. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during POST request: $error');
      // Handle the error as needed
    }
  }

 Future<List<CollabRequestDto>> getAllCollabRequest() async {
    String? token =
        await getSavedToken(); // Replace with your actual authentication token

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/collab-requests'),
      headers: {'Authorization': '$token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => CollabRequestDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}


