// views/reservation_now.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boxed_project/controllers/reservation_controller.dart';
import 'package:boxed_project/provider/auth_provider.dart';
import 'package:boxed_project/models/reservation_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:flutter/services.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/widgets/custom_text_field.dart';
import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';

class ReserveNow extends StatefulWidget {

  const ReserveNow({super.key});

  @override
  State<ReserveNow> createState() => _ReserveNowState();

}

class _ReserveNowState extends State<ReserveNow> {

  late ReservationController _controller;
  final _formKey = GlobalKey<FormState>();
  String cardTypeIcon = ''; //Depend CardIcon
  String selectedCountry = 'United States'; // Default country
  final List<String> countries = Constants.countries;
  final TextEditingController expirationController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  final _reservation = Reservation(
    email: '',
    phoneNumber: '',
    cardEmail: '',
    cardNumber: '',
    expirationDate: '',
    securityCode: '',
    country: '',
    zipCode: '',
  );

  // Function to format expiration date
  void _formatExpirationDate(String value) {
    if (value.length == 2 && !value.contains('/')) {
      expirationController.text = '$value/';
      expirationController.selection = TextSelection.fromPosition(
        TextPosition(offset: expirationController.text.length),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Set initial checkbox status based on role
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _controller = ReservationController(authProvider);
  }

  @override
  void dispose() {
    expirationController.dispose();
    cvcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthProvider>(context).user;
    bool isStudent = _controller.isStudent();
    bool isParent = isStudent ? false : true;

    // Dynamic labels based on role
    String email1Label = isStudent ? "Student Email" : "Parent/Family Member Email";
    String phone1Label = isStudent ? "Student Phone Number" : "Parent/Family Member Phone Number";
    String email2Label = isStudent ? "Parent/Family Member Email" : "Student Email";
    String phone2Label = isStudent ? "Parent/Family Member Phone Number" : "Student Phone Number";

    bool isLoggedIn = Provider.of<AuthProvider>(context).isLoggedIn;
    if (!isLoggedIn) {
      // You can navigate to the login screen here
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }


    final size = MediaQuery.sizeOf(context);
    return Scaffold(
    body: Stack(
      children: [
        // Background image for the entire screen
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),
        CustomScrollView(
          slivers: [
            // Fixed header with SliverAppBar
            SliverAppBar(
              surfaceTintColor: Palette.themecolor,
              backgroundColor: Palette.themecolor,
              pinned: true,
              expandedHeight: 0,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              title: Image.asset(
                Constants.splashLogo,
                width: 200,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: GestureDetector(
                    onTap: () {
                      Go.route(
                        context,
                        const ReserveNow(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Palette.themecolor),
                      ),
                      child: const Text(
                        "RESERVE NOW",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                CustomIconButton(
                  onTap: () {},
                  child: const Icon(
                    CupertinoIcons.bell,
                    color: Colors.white,
                  ),
                ),
                10.kW,
              ],
            ),

            // Body content
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        "Ready to Secure Your Summer Storage? Sign Up Below!",
                        style: TextStyle(
                          fontSize: largefontsize5,
                          fontWeight: boldfontweight,
                          color: Colors.white,
                        ),
                      ),
                      15.kH,
                      Row(
                        children: [
                          TextFormField(
                            initialValue: user?.firstName,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                borderRadius:BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                  color: Colors.grey, 
                                  width: 1.5,      
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: boldfontweight,
                            ),
                            readOnly: true,
                          ),
                          // TextFormField(
                          //   initialValue: user?.lastName,
                          //   decoration: InputDecoration(labelText: 'Last Name'),
                          //   readOnly: true,
                          // ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Checkbox(
                            value: isStudent,
                            onChanged: (bool? value) {
                              setState(() {
                                isStudent = value ?? false;
                                isParent =
                                    !isStudent; // Toggle the other checkbox
                              });
                            },
                          ),
                          Text("Student"),
                          Checkbox(
                            value: isParent,
                            onChanged: (bool? value) {
                              setState(() {
                                isParent = value ?? false;
                                isStudent =
                                    !isParent; // Toggle the other checkbox
                              });
                            },
                          ),
                          Text("Parent/Family Member"),
                        ],
                      ),
                      Text(email1Label),
                      TextFormField(
                        initialValue: user?.email,
                        decoration:
                            InputDecoration(labelText: 'Your Email Address'),
                        readOnly: true,
                      ),
                      Text(phone1Label),
                      TextFormField(
                        initialValue: user?.phoneNumber,
                        decoration:
                            InputDecoration(labelText: 'Your Phone Number'),
                        readOnly: true,
                      ),
                      Text(email2Label),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email Address'),
                        onChanged: (value) => _reservation.email = value,
                      ),
                      Text(phone2Label),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        onChanged: (value) => _reservation.phoneNumber = value,
                      ),
                      15.kH,
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: mediumfontsize1,
                          color: themeblackcolor,
                          fontWeight: boldfontweightvar1,
                        ),
                      ),
                      20.kH,
                      Text('Application/Reservation Fee'),
                      10.kH,
                      Text("Price: \$50.00",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      20.kH,
                      Text("Securely Pay Via Stripe"),
                      Text("Email"),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'you@example.com'),
                        onChanged: (value) => _reservation.cardEmail = value,
                      ),
                      Text("Card Number"),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: '1234 1234 1234 1234',
                          suffixIcon: Icon(getCardIcon(cardTypeIcon)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _reservation.cardNumber = value;
                            cardTypeIcon = _controller.detectCardType(value);
                          });
                        },
                      ),
                      Text('Expiration Date'),
                      TextFormField(
                        controller: expirationController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: '01/01',
                          hintText: 'MM/YY',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(5),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            _formatExpirationDate(newValue.text);
                            return newValue;
                          }),
                        ],
                        onChanged: (value) => _reservation.expirationDate = value,
                      ),
                      Text('Security Code'),
                      TextFormField(
                        controller: cvcController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'CVC',
                          suffixIcon: Icon(Icons.lock), // Example suffix icon
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(
                              3), // Limit to 3 digits
                        ],
                        onChanged: (value) => _reservation.securityCode = value,
                      ),
                      Text('Country'),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(labelText: 'Country'),
                        value: selectedCountry,
                        onChanged: (String? newCountry) {
                          setState(() {
                            selectedCountry = newCountry!;
                          });
                          _reservation.country = newCountry!;
                        },
                        items: countries.map((country) {
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(country),
                          );
                        }).toList(),
                      ),
                      Text('ZIP Code'),
                      TextFormField(
                        decoration: InputDecoration(labelText: '12345'),
                        onChanged: (value) => _reservation.zipCode = value,
                      ),
                            
                      20.kH,
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _controller.submitReservation(_reservation);
                          }
                        },
                        child: const Text('Reserve Now'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );    
  }

  IconData getCardIcon(String cardType) {
    switch (cardType) {
      case 'Visa':
        return FontAwesomeIcons.ccVisa;
      case 'MasterCard':
        return FontAwesomeIcons.ccMastercard;
      case 'Amex':
        return FontAwesomeIcons.ccAmex;
      case 'Discover':
        return FontAwesomeIcons.ccDiscover;
      default:
        return FontAwesomeIcons.creditCard;
    }
  }
}
