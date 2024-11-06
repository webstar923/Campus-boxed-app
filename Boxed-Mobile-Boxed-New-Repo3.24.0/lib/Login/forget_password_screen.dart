import 'dart:convert';

import 'package:boxed_project/Login/opt_screen.dart';
import 'package:boxed_project/common/base_widget.dart';
import 'package:boxed_project/http/api_service.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/Login/update_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
const ForgetPasswordScreen({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> getOtp(BuildContext context) async {
  showLoadingDialog(context);

  void callback(String responseBody, {bool isError = false}) {
  if (isError) {
    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
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
    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
    String message = jsonResponse['message'] ?? 'OTP sent successfully!';
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
        String email = emailController.text;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen(emailId: email)),
        );
      });
    }
  }
}

  await ApiService(context).otpSend(
    emailController.text.toString(),
    callback,
  );
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
              height: 80 +
                  MediaQuery.of(context)
                      .padding
                      .top, // Add status bar height to the container height
              color: ColorConstants.primaryColor,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
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
                padding:
                    EdgeInsets.zero, // Ensure ListView starts from the very top
                children: [
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Forget Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        color: ColorConstants.primaryBlackColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'It\'s Ok! reset your Password',
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
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
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
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  getOtp(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.primaryColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                foregroundColor: Colors
                                    .white, // Explicitly set text color to white
                              ),
                              child: const Text('Verify'),
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
