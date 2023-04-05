import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class UserRepository {
  static Future<http.Response> getUsers(String endpoint) async {
    final response = await http.get(
      Uri.parse('${Constants.baseUrl}/$endpoint'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed ');
    }

    return response;
  }

  static Future<http.Response> addUser(String endpoint, data) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add user');
    }

    return response;
  }
}
