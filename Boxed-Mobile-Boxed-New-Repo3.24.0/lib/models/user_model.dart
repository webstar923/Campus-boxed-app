class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? role;
  final String? location;
  final String? phoneNumber;
  final String? customerId;
  final String? updatedAt;
  final String? createdAt;
  final int? id;
  final String? password; // Add password if needed for login

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.location,
    this.phoneNumber,
    this.customerId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      role: json['role'],
      location: json['location'],
      phoneNumber: json['phone_number'],
      customerId: json['customer_id'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'role': role,
      'location': location,
      'phone_number': phoneNumber,
      'customer_id': customerId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
      'password': password,
    };
  }
}
