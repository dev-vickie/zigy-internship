import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zigy_internship/utils/snackbars.dart';
import '../models/user_model.dart';
import 'user_repository.dart';

class UserController {
  static Future<List<User>> getUsers(BuildContext context) async {
    try {
      final response = await UserRepository.getUsers('users?page=2');

      final data = json.decode(response.body)['data'] as List<dynamic>;

      return data.map((json) => User.fromJson(json)).toList();
    } catch (e) {
      showErrorSnackBar(context, e.toString());
      return [];
    }
  }

  static Future<void> addUser(BuildContext context, User user) async {
    try {
      final response = await UserRepository.addUser('users', user.toJson());
      debugPrint(response.body);
      showSuccessSnackBar(context, "Added user successfully");
      Navigator.pop(context);
    } catch (e) {
      showErrorSnackBar(context, e.toString());
    }
  }
}
