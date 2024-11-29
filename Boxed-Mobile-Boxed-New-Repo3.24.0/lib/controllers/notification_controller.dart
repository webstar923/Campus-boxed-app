import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:boxed_project/http/api_constant.dart';

class NotificationController {

  Future<String?> registerNotificationUser(String email, String phoneNumber) async {
    final url  = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.registerNotificationUser}');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "phone_number": phoneNumber}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        return 'Success: Notification Register';
      } else {
        throw Exception(responseData['data']);
      }
    } else {
      throw Exception('Failed: ${response.statusCode}');
    }
  }
}