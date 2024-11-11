import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:boxed_project/models/user_model.dart';
import 'package:boxed_project/http/api_constant.dart';
class LoginController {

  Future<String> loginUser(UserModel user) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userLogin);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": user.email, "password": user.password}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message']; // Assuming 'message' is in the response
    } else {
      return 'Login failed: ${response.statusCode}';
    }
  }
}