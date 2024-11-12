// controllers/reservation_controller.dart
import 'package:boxed_project/models/reservation_model.dart';
import 'package:boxed_project/provider/auth_provider.dart';

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

  void submitReservation(Reservation reservation) {
    // Handle reservation submission logic here
  }
}
