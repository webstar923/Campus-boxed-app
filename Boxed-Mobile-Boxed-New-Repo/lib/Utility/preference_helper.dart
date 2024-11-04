import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static final PreferencesHelper _instance = PreferencesHelper._internal();
  late SharedPreferences _prefs;

  factory PreferencesHelper() {
    return _instance;
  }

  PreferencesHelper._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Getter and Setter for username
  String? get username => _prefs.getString('username');
  set username(String? value) {
    _prefs.setString('username', value ?? '');
  }

  // Getter and Setter for isLoggedIn
  int? get isLoggedIn => _prefs.getInt('isLoggedIn');
  set isLoggedIn(int? value) {
    _prefs.setInt('isLoggedIn', value ?? 0);
  }

  int? get customer_id => _prefs.getInt('customer_id');
  set customer_id(int? value) {
    _prefs.setInt('customer_id', value ?? 0);
  }

  // Getter and Setter for currency
  String? get currency => _prefs.getString('currency');
  set currency(String? value) {
    _prefs.setString('currency', value ?? '');
  }

  // Method to remove all preferences
  Future<void> clear() async {
    await _prefs.clear();
  }
}

