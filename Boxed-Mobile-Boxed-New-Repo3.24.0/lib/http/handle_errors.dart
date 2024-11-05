import 'dart:convert';
import 'package:boxed_project/common/base_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpError {
  final BuildContext context;

  HttpError(this.context);

  Future<void> handleHttpError(http.Response response, bool isAdmin) async {
    if (response.statusCode == 401) {
      if (isAdmin) {
        clearAdminLogin();
      } else {
        clearWorkerToken();
      }
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      // Client-side error
      if (kDebugMode) {
        print(response.body);
      }
      final jsonData = jsonDecode(response.body);
      final errorMessage = jsonData['message'] ?? 'SomeThing Went Wrong';
      showCustomSnackBar(errorMessage, context);
    } else if (response.statusCode >= 500 && response.statusCode < 600) {
      // Server-side error
      // showCustomSnackBar(serverExceptionMessage.tr(), context);
      // Utility().errorToast(context, LocaleKeys.serverExceptionMessage.tr());
    } else if (response.statusCode == 0) {
      // Timeout error
      // Utility().errorToast(context, LocaleKeys.timeoutErrorMessage.tr());
    } else {
      // Other errors (e.g., network errors, timeouts)
      // Utility().errorToast(context, LocaleKeys.networkExceptionMessage.tr());
    }
  }

  Future<void> clearAdminLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('adminToken');
  }

  Future<void> clearWorkerToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
  }
}
