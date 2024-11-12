// models/reservation_model.dart
class Reservation {
  String email;
  String phoneNumber;
  String cardEmail;
  String cardNumber;
  String expirationDate;
  String securityCode;
  String country;
  String zipCode;

  Reservation({
    required this.email,
    required this.phoneNumber,
    required this.cardEmail,
    required this.cardNumber,
    required this.expirationDate,
    required this.securityCode,
    required this.country,
    required this.zipCode,
  });
}