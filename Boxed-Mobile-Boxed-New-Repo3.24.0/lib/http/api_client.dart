import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<http.Response> makeAuthenticatedRequest(String url, String method, {Map<String, String>? headers, dynamic body}) async {
  // Retrieve the token
  String? token = await storage.read(key: 'access_token');
  headers ??= {"Content-Type": "application/json"};
  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }

  if (method.toUpperCase() == 'POST') {
    return await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
  } else if(method.toUpperCase() == 'GET') {
    return await http.get(
      Uri.parse(url),
      headers: headers,
    );
  } else {
    return await http.put(
      Uri.parse(url),
      headers: headers,
      body: body
    );    
  }
}
