import 'dart:convert';

import 'package:gdsc_2024/model/post.dart';
import 'package:gdsc_2024/services/api_service.dart';
import 'package:gdsc_2024/services/global.dart';
import 'package:http/http.dart' as http;


class PostService {
  Future<List<Post>> get5NewestPosts() async {
    String? token = await getSavedToken();

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/post/newest'),
      headers: {'Authorization': '$token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
  Future<List<Post>> getAllPosts() async {
    String? token = await getSavedToken();

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/post'),
      headers: {'Authorization': '$token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
}