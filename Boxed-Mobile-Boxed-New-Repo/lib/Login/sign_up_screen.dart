
import 'dart:convert';
import 'package:boxed_project/Login/login_screen.dart';
import 'package:boxed_project/Utility/constant.dart';
import 'package:boxed_project/common/base_widget.dart';
import 'package:boxed_project/http/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:boxed_project/TabBar/tabbar_screen.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Set this to transparent to see the native color
    statusBarIconBrightness: Brightness.light, // Set the status bar icons to light
  ));
  runApp(const MaterialApp(home: SignUpScreen())); // Wrap in MaterialApp to provide navigation context
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  int role = 3;
  
  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TabBarScreen(),
          ),
        );
      }
    } catch (error) {
      print('Error during Google Sign-In: $error');
    }
  }

  Brightness get preferredStatusBarIconBrightness => Brightness.light;
  final _formKey = GlobalKey<FormState>();
  bool _isStudent = false;
  int _role = 2;
  String? selectedLocation;
  bool _isCustomLocation = false;
  
  bool _showPassword = false;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  final TextEditingController stripeEmailController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController securityCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  Future<void> register(BuildContext context) async {
  showLoadingDialog(context);

  void callback(String responseBody, {bool isError = false}) {
    try {
      Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

      if (isError) {
        String message = jsonResponse['error'] ?? 'Something went wrong';
        hideLoadingDialog(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        // Handle successful registration
        String message = jsonResponse['message'] ?? 'Registration successful!';
        String token = jsonResponse['data']['token'];
        storeAdminToken(token);

        if (mounted) {
          setState(() {
            hideLoadingDialog(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TabBarScreen()),
            );
          });
        }
      }
    } catch (e) {
      hideLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error occurred: $e',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  await ApiService(context).register(
    context,
    firstNameController.text.toString(),
    lastNameController.text.toString(),
    phoneNumberController.text.toString(),
    locationController.text.toString(),
    emailController.text.toString(),
    role, // Assuming role is set dynamically elsewhere
    passwordController.text.toString(),
    passwordConfirmationController.text.toString(),
    "shjcshjvcshv",
    callback,
  );
}

 Future<void> storeAdminToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('adminToken', token);
  }

  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your card number';
    }
    if (value.length != 16) {
      return 'Card number must be 16 digits';
    }
    return null;
  }

  String? validateSecurityCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the security code';
    }
    if (value.length != 3) {
      return 'Security code must be 3 digits';
    }
    return null;
  }

  String? validateExpirationDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the expiration date';
    }
    try {
      final expirationDate = DateFormat('MM/yy').parseStrict(value);
      if (expirationDate.isBefore(DateTime.now())) {
        return 'Expiration date cannot be in the past';
      }
    } catch (e) {
      return 'Invalid expiration date format';
    }
    return null;
  }

  Future<void> selectExpirationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        expiryDateController.text = DateFormat('MM/yy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back button from navigating back
        return Future.value(false);
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 140 +
                  MediaQuery.of(context).padding.top, // Add status bar height to the container height
              color: ColorConstants.primaryColor,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: Center(
                      child: Image.asset(
                        'assets/images/boxed_logo.png',
                        height: 67,
                        width: 212,
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    left: 0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero, // Ensure ListView starts from the very top
                children: [
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryBlackColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Please enter your details',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        color: ColorConstants.primarygreyColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: phoneNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                           const SizedBox(height: 24.0),
                        const Text(
                          'Are you a Student or Parent/Family Member',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Wrap(
                          spacing: 24.0,
                          runSpacing: 8.0,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<int>(
                                  value: 2,
                                  groupValue: _role,
                                  onChanged: (value) {
                                    setState(() {
                                      _role = value ?? 2;
                                    });
                                  },
                                ),
                                const Text('Student'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<int>(
                                  value: 3,
                                  groupValue: _role,
                                  onChanged: (value) {
                                    setState(() {
                                      _role = value ?? 3;
                                    });
                                  },
                                ),
                                const Text('Parent/Family Member'),
                              ],
                            ),
                          ],
                        ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: passwordConfirmationController,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8.0),
                            Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                              ),
                              borderRadius: BorderRadius.circular(4), // Rounded corners
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                value: selectedLocation,
                                items: Constant.schoolList.map((location) {
                                  return DropdownMenuItem<String>(
                                    value: location,
                                    child: Text(
                                      location,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      overflow: TextOverflow.ellipsis, // Handle text overflow
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedLocation = value;
                                    _isCustomLocation = selectedLocation == 'Custom';
                                    if (_isCustomLocation) {
                                      locationController.text = '';
                                    }
                                  });
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                  border: InputBorder.none, // Remove default border
                                ),
                                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                                isExpanded: true,
                                hint: const Text( // Placeholder text
                                  'Select a location',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey, // Color of the placeholder
                                  ),
                                ), // Make the dropdown fill the container width
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Application / Reservation Fee\nPrice: \$50.00',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Total: \$50.00',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Securely Pay Via Stripe',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: cardNumberController,
                            decoration: const InputDecoration(
                              labelText: 'Card Number',
                              border: OutlineInputBorder(),
                            ),
                            validator: validateCardNumber,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: expiryDateController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Expiration Date',
                              border: OutlineInputBorder(),
                            ),
                            validator: validateExpirationDate,
                            onTap: () => selectExpirationDate(context),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: securityCodeController,
                            decoration: const InputDecoration(
                              labelText: 'Security Code',
                              border: OutlineInputBorder(),
                            ),
                            validator: validateSecurityCode,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: countryController,
                            decoration: const InputDecoration(
                              labelText: 'Country',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your country';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // if (_formKey!.currentState!.validate()) {
                                 register(context);
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Reserve'),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Don\'t have an account? Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

