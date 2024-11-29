// controllers/reservation_controller.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:boxed_project/models/user_model.dart';
import 'package:boxed_project/models/reservation_model.dart';
import 'package:boxed_project/provider/auth_provider.dart';
import 'package:boxed_project/http/api_constant.dart';
import 'package:boxed_project/http/api_client.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

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

  Future<String?> submitReservation(Reservation reservation, String paymentID) async {

    UserModel? user = authProvider.user;
//-----------------------Customized Card Form Case ----------------------//
    // try {
    //   final cardDetails = CardDetails(
    //     number: reservation.cardNumber.trim(),
    //     expirationMonth: int.parse(reservation.expirationDate.split('/')[0]),
    //     expirationYear: int.parse('20${reservation.expirationDate.split('/')[1]}'),
    //     cvc: reservation.securityCode.trim(),
    //   );
    //   final address = Address(
    //     city: 'Houston',
    //     country: 'US',
    //     line1: '1459  Circle Drive',
    //     line2: '',
    //     state: 'Texas',
    //     postalCode: '77063',
    //   );

    // final paymentMethod = await Stripe.instance.createPaymentMethod(
    //   params: PaymentMethodParams.card(
    //     paymentMethodData: PaymentMethodData(
    //       billingDetails: BillingDetails(
    //         email: reservation.cardEmail.trim(),
    //         address: address,
    //       ),
    //     ),
    //   ),
    // );

    // } catch (e) {
    //   print('Error: $e');
    // }
//-----------------------Customized Card Form Case ----------------------//
    final url  = '${ApiConstants.baseUrl}${ApiConstants.reservations}';
    final body = jsonEncode({
        "storage_box_id": 1,
        // "sender_id": user?.id,
        "receiver_email": reservation.email,
        "receiver_phone": reservation.phoneNumber,
        // "card_number": reservation.cardNumber,
        // "expiration_date": reservation.expirationDate,
        // "cvc": reservation.securityCode,
        // "zip_code": reservation.zipCode,
        "paymentID" : paymentID
        });
    final response = await makeAuthenticatedRequest(url, 'POST', body: body);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        return 'Reservation Success';
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Reservation failed: ${response.statusCode}');
    }
  }
}
