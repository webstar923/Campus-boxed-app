// models/user_sign_up_model.dart
class UserModel {
  String firstName;
  String lastName;
  String email;
  String phone;
  String userType;
  String password;
  String location;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.userType,
    required this.password,
    required this.location
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phone,
      'role': userType,
      'password': password,
      'location': location,
    };
  }
}
