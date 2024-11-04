import 'dart:convert';

import 'package:boxed_project/Login/update_password_screen.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/common/base_widget.dart';
import 'package:boxed_project/http/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
const OtpScreen({Key? key, required this.emailId}) : super(key: key);
final String emailId;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int otpLength = 6; // Length of the OTP

  List<FocusNode> focusNodes = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < otpLength; i++) {
      focusNodes.add(FocusNode());
      controllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (int i = 0; i < otpLength; i++) {
      focusNodes[i].dispose();
      controllers[i].dispose();
    }
    super.dispose();
  }

  void onOtpEntered() {
    String otp = controllers.map((controller) => controller.text).join();
    if (otp.length == otpLength) {
      callOtpApi('123456');
    }
  }

  void callOtpApi(String otp) async {
  showLoadingDialog(context);

  void callback(String responseBody, {bool isError = false}) {
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
      // Handle successful response
      String message = jsonResponse['message'] ?? 'Verification successful!';
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
            MaterialPageRoute(
              builder: (context) => UpdatePasswordScreen(emailId: widget.emailId), // Use widget.emailId here
            ),
          );
        });
      }
    }
  }

  try {
    await ApiService(context).otpVerify(
      widget.emailId, // Use widget.emailId here
      otp,
      callback,
    );
  } catch (error) {
    hideLoadingDialog(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'An error occurred: $error',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Container(
              height: 80 + MediaQuery.of(context).padding.top,
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
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Enter Valid OTP',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Inter',
                  color: ColorConstants.primaryBlackColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'A 6-digit code has been sent to ${widget.emailId}', // Fixed interpolation
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  color: ColorConstants.primarygreyColor,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(otpLength, (index) {
                  return SizedBox(
                    width: 40,
                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < otpLength - 1) {
                          FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                        }

                        // Trigger API call only when all fields are filled
                        if (controllers.every((controller) => controller.text.isNotEmpty)) {
                          onOtpEntered();
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: OtpScreen(emailId: 'example@example.com'),
  ));
}