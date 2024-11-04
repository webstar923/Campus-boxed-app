import 'dart:convert';

import 'package:boxed_project/http/api_constant.dart';
import 'package:boxed_project/http/handle_request.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final BuildContext context;

  ApiService(this.context);

  Future<void> userLogin(String email, String password, ResponseCallback callback) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.userLogin}';
    var body = {
      'email': email,
      'password': password,
    };
    await HandleRequest(context)
        .handleRequest('POST', url, "", false, body: body, callback: callback);
  }

  Future<void> register(
    BuildContext context,
    String firstName,
    String lastName,
    String phoneNumber,
    String location,
    String email,
    int role,
    String password,
    String passwordConfirmation,
    String stripeTokenId,
    ResponseCallback callback) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.register}';
    var body = {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'location': location,
      'email': email,
      'role': role,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'stripe_token_id': stripeTokenId
    };
    await HandleRequest(context).handleRequest('POST', url, "", false, body: body, callback: callback);
  }

  Future<void> userLogout(ResponseCallback callback) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.logout}';
    var token = (await getAdminToken()).toString();
    await HandleRequest(context)
        .handleRequest('POST', url, token, true, body: {}, callback: callback);
  }

  Future<void> otpSend(String email, ResponseCallback callback) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.otpSend}';
    var body = {
      'email': email
    };
    await HandleRequest(context)
        .handleRequest('POST', url, "", false, body: body, callback: callback);
  }

  Future<void> otpVerify(String email, String otp, ResponseCallback callback) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.otpVerify}';
    var body = {
      'email': email,
      'otp': otp
    };
    await HandleRequest(context)
        .handleRequest('POST', url, "", false, body: body, callback: callback);
  }

  Future<void> resetPassword(String email, String password, String passwordConfirmation, ResponseCallback callback) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.resetPassword}';
    var body = {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    };
    var token = (await getAdminToken()).toString();
    await HandleRequest(context)
        .handleRequest('POST', url, token, true, body: body, callback: callback);
  }

  static Future<String?> getAdminToken() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('adminToken');
  }

  Future<void> getBannerImages(ResponseCallback callback) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.banner}';
    var token = (await getAdminToken()).toString();
    await HandleRequest(context).handleRequest('GET', url, token, true, body: {}, callback: callback);
  }

  Future<void> getPackagingWrapperImages(ResponseCallback callback) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.packagingWrapper}';
    await HandleRequest(context).handleRequest('GET', url, "", false, body: {}, callback: callback);
  }

  Future<void> getUserDetails(ResponseCallback callback) async {
    var url = '${ApiConstants.baseUrl}${ApiConstants.userDetails}';
    var token = (await getAdminToken()).toString();
    await HandleRequest(context).handleRequest('GET', url, token, true, body: {}, callback: callback);
  }

  Future<void> reservationInfomationUpdate(
  BuildContext context,
  Map<String, dynamic> payload,
  ResponseCallback callback,
) async {
  final url = '${ApiConstants.baseUrl}${ApiConstants.reservations}';
  final token = (await getAdminToken()).toString();
  
  await HandleRequest(context).handleRequest('POST', url, token, true, body: payload, callback: callback);
}
}