// controllers/reservation_controller.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:boxed_project/models/user_model.dart';
import 'package:boxed_project/models/reservation_model.dart';
import 'package:boxed_project/provider/auth_provider.dart';
import 'package:boxed_project/http/api_constant.dart';

class ReservationController {
  final AuthProvider authProvider;

  ReservationController(this.authProvider);

  bool isStudent() => authProvider.user?.role == 2;

  // Detect card type based on number
  String detectCardType(String cardNumber) {
    if (cardNumber.startsWith('4')) return 'Visa';
    if (cardNumber.startsWith('5')) return 'MasterCard';
    if (cardNumber.startsWith('3')) return 'Amex';
    if (cardNumber.startsWith('6')) return 'Discover';
    return 'Unknown';
  }

  Future<Reservation?> submitReservation(Reservation reservation) async {
    // Handle reservation submission logic here
    print('fff');
    print(authProvider.user?.id);
    print('object');
    UserModel? user = authProvider.user;
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.reservations);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "storage_box_id": 1,
        "sender_id": user?.id,
        "receiver_email": reservation.email,
        "receiver_phone": reservation.phoneNumber,
        "card_number": reservation.cardNumber,
        "expiration_date": reservation.expirationDate,
        "cvc": reservation.securityCode,
        "zip_code": reservation.zipCode,
        }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        // return UserModel.fromJson(responseData['data']);
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Reservation failed: ${response.statusCode}');
    }
  }
}
