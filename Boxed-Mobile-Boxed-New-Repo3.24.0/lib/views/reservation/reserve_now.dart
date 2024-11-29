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
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/route_structure/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';
import 'package:animate_do/animate_do.dart';
import 'package:boxed_project/views/PortalScreens/reservation_details_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:boxed_project/views/widget/customsnapbar.dart';

class ReserveNow extends StatefulWidget {

  const ReserveNow({super.key});

  @override
  State<ReserveNow> createState() => _ReserveNowState();

}

class _ReserveNowState extends State<ReserveNow> {

  late ReservationController _controller;
  final _formKey = GlobalKey<FormState>();

  //Card Form
  final cardFormController = CardFormEditController();

  //Old Customized Card Form
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

  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    // Set initial checkbox status based on role
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _controller = ReservationController(authProvider);
    cardFormController.addListener(update);

  }

  @override
  void dispose() {
    expirationController.dispose();
    cvcController.dispose();
    cardFormController.removeListener(update);
    cardFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.sizeOf(context);
    final user = Provider.of<AuthProvider>(context).user;
    bool isStudent = _controller.isStudent();
    bool isParent = isStudent ? false : true;

    // Dynamic labels based on role
    String email1Label = isStudent ? "Student Email" : "Parent/Family Member Email";
    String phone1Label = isStudent ? "Student Phone Number" : "Parent/Family Member Phone Number";
    String email2Label = isStudent ? "Parent/Family Member Email" : "Student Email";
    String phone2Label = isStudent ? "Parent/Family Member Phone Number" : "Student Phone Number";

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Go.named(context, RouteName.welcomeScreen);
        return false;
      },
      child:Scaffold(
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
                  centerTitle: true,
                  title: Image.asset(
                    Constants.splashLogo,
                    width: 200,
                  ),
                  actions: [
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
                          Align(
                            alignment: Alignment.centerLeft, // Aligns text to the left
                            child: Text(
                              'Name',
                              style: TextStyle(
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.kH,
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  initialValue: user?.firstName,
                                  decoration: customInputDecoration('First Name'),
                                  style: TextStyle(
                                    fontSize: mediumfontsize3,
                                    color: Colors.black,
                                    fontWeight: boldfontweight,
                                  ),
                                  readOnly: true,
                                ),
                              ),
                              10.kW, // Add spacing between the text fields
                              Expanded(
                                child: TextFormField(
                                  initialValue: user?.lastName,
                                  decoration: customInputDecoration('Last Name'),
                                  style: TextStyle(
                                    fontSize: mediumfontsize3,
                                    color: Colors.black,
                                    fontWeight: boldfontweight,
                                  ),
                                  readOnly: true,
                                ),
                              ),
                            ],
                          ),
                          15.kH,
                          Align(
                            alignment: Alignment.centerLeft, // Aligns text to the left
                            child: Text(
                              'Are You A Student Or Parent/Family Member?',
                              style: TextStyle(
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.kH,
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
                              Text(
                                "Student",
                                style: TextStyle(
                                  fontSize: mediumfontsize3,
                                  fontWeight: boldfontweight,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          10.kH,
                          Row(
                            children: [
                              Checkbox(
                                value: isParent,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isParent = value ?? false;
                                    isStudent =
                                        !isParent;
                                  });
                                },
                              ),
                              5.kW,
                              Text(
                                "Parent/Family Member",
                                style: TextStyle(
                                  fontSize: mediumfontsize3,
                                  fontWeight: boldfontweight,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          15.kH,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              email1Label,
                              style: TextStyle(
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.kH,
                          TextFormField(
                            initialValue: user?.email,
                            decoration: customInputDecoration('Your Email Address'),
                            style: TextStyle(
                              fontSize: mediumfontsize3,
                              color: Colors.black,
                              fontWeight: boldfontweight,
                            ),
                            readOnly: true,
                          ),
                          15.kH,
                          Align(
                            alignment: Alignment.centerLeft, // Aligns text to the left
                            child: Text(
                              phone1Label,
                              style: TextStyle(
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.kH,
                          TextFormField(
                            initialValue: user?.phoneNumber,
                            decoration: customInputDecoration('Your Phone Number'),
                            style: TextStyle(
                              fontSize: mediumfontsize3,
                              color: Colors.black,
                              fontWeight: boldfontweight,
                            ),
                            readOnly: true,
                          ),
                          15.kH,
                          Align(
                            alignment: Alignment.centerLeft, // Aligns text to the left
                            child: Text(
                              email2Label,
                              style: TextStyle(
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.kH,
                          TextFormField(
                            decoration: customInputDecoration('Email Address'),
                            style: TextStyle(
                              fontSize: mediumfontsize3,
                              color: Colors.black,
                              fontWeight: boldfontweight,
                            ),
                            onChanged: (value) => _reservation.email = value,
                            validator: (value) => value!.isEmpty ? "Enter Email Address" : null,
                          ),
                          15.kH,
                          Align(
                            alignment: Alignment.centerLeft, // Aligns text to the left
                            child: Text(
                              phone2Label,
                              style: TextStyle(
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.kH,
                          TextFormField(
                            decoration: customInputDecoration('Phone Number'),
                            style: TextStyle(
                              fontSize: mediumfontsize3,
                              color: Colors.black,
                              fontWeight: boldfontweight,
                            ),
                            onChanged: (value) => _reservation.phoneNumber = value,
                            // validator: (value) => value!.isEmpty ? "Enter Phone Number" : null,
                          ),
                          15.kH,
                          Align(
                            alignment: Alignment.centerLeft, // Aligns text to the left
                            child: Text(
                              'Application/Reservation Fee',
                              style: TextStyle(
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.kH,
                          Align(
                            alignment: Alignment.centerLeft, // Aligns text to the left
                            child: Text(
                              "Price: \$50.00",
                              style: TextStyle(
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          15.kH,
                          Align(
                            alignment: Alignment.centerLeft, // Aligns text to the left
                            child: Text(
                              "Securely Pay Via Stripe",
                              style: TextStyle(
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.kH,
                          Align(
                            alignment: Alignment.centerLeft, // Aligns text to the left
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          10.kH,
                          TextFormField(
                            decoration: customInputDecoration('you@example.com'),
                            style: TextStyle(
                              fontSize: mediumfontsize3,
                              color: Colors.black,
                              fontWeight: boldfontweight,
                            ),
                            onChanged: (value) => _reservation.cardEmail = value,
                            validator: (value) => value!.isEmpty ? "Enter email" : null,
                          ),
                          15.kH,

                          CardFormField(
                            controller: cardFormController,
                            countryCode: 'US',
                            style: CardFormStyle(
                              backgroundColor: Colors.white,
                              borderColor: Colors.blueGrey,
                              textColor: Colors.black,
                              placeholderColor: Colors.blue,
                              borderRadius: 5
                            ),
                          ),
                          
                          CustomButton(
                            onTap:() => {
                              cardFormController.details.complete == true ? _reserve(context) : null
                            },
                            height: 55,
                            buttoncolor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF004BA0), // Button color
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.white),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  "Reserve Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          10.kH,
                          if (_isLoading)
                            Container(
                              color: Colors.white.withOpacity(0),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
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
      )
    );    
  }

  void _reserve(context) async {

    if (!cardFormController.details.complete) {
      return;
    }

    if (_formKey.currentState!.validate() ?? false) {
        setState(() {
          _isLoading = true;
        });

      try {

        final billingDetails = BillingDetails(
          email: _reservation.cardEmail,
        );

        final paymentMethod = await Stripe.instance.createPaymentMethod(
            params: PaymentMethodParams.card(
                paymentMethodData: PaymentMethodData(
                  billingDetails: billingDetails,
                ),
            )
        );
        String? reservedResuilt = await _controller.submitReservation(_reservation,paymentMethod.id);
        setState(() {
          _isLoading = false;
        });
        if(reservedResuilt == 'Reservation Success')
        {
          CustomSnackBar.show(context, 'The reservation was successful!');
          Go.route(
            context,
            const ReservationDetailScreen(),
          );            
        }      
      } catch (error) {
        
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $error')));
        rethrow;        
        // showAnimatedWarningDialog(context, error.toString());
      }
    }
                        
  }

  void showAnimatedWarningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SlideInDown(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: Colors.white,
            contentPadding: const EdgeInsets.all(7),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.redAccent,
                  size: 35,
                ),
                5.kH,
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  side: BorderSide(color: Colors.blue, width: 2), // Set border color and width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Set border radius
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Add padding
                ),
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.blue), // Set text color
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  // Function to format expiration date
  void _formatExpirationDate(String value) {
    if (value.length == 2 && !value.contains('/')) {
      expirationController.text = '$value/';
      expirationController.selection = TextSelection.fromPosition(
        TextPosition(offset: expirationController.text.length),
      );
    }
  }

  void update() => setState(() {});

  InputDecoration customInputDecoration(String labelText) {
    return InputDecoration(
      hintText: labelText,
      filled: true,
      fillColor: Colors.grey[200],
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
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
