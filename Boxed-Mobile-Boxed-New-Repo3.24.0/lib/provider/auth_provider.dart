import 'package:flutter/material.dart';
import 'package:boxed_project/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  UserModel? _user; // Add user model

  bool get isLoggedIn => _isLoggedIn;
  UserModel? get user => _user;

  void login(UserModel user) {
    _isLoggedIn = true;
    _user = user;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    _user = null; // Clear user data on logout
    notifyListeners();
  }
}
