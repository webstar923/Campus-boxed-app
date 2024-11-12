
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:boxed_project/models/user_model.dart';
import 'package:boxed_project/http/api_constant.dart';

class LoginController {
  Future<UserModel?> loginUser(UserModel user) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userLogin);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": user.email, "password": user.password}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        return UserModel.fromJson(responseData['data']);
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Login failed: ${response.statusCode}');
    }
  }
}
