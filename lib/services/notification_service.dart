import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gdsc_2024/model/notification.dart';
import 'package:gdsc_2024/services/api_service.dart';
import 'package:gdsc_2024/services/global.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  Future<List<NotificationModel>> getAllNotifications() async {
    String? token = await getSavedToken();

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/notifications'),
      headers: {'Authorization': '$token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}
