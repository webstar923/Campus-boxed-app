// controllers/user_controller.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_sign_up_model.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/route_structure/go_router.dart';
import 'package:boxed_project/http/api_constant.dart';

class UserController {

  Future<String> registerUser(UserModel user) async {
    // final url = Uri.parse("https://wov.tvd.mybluehost.me/api/register");
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.register);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      print("User registered successfully");
      return jsonDecode(response.body)['message'];
    } else {
      print("Failed to register user: ${response.body}");
      return 'Register failed: ${response.statusCode}';
    }
  }
}
