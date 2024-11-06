import 'dart:convert';

import 'package:boxed_project/common/base_widget.dart';
import 'package:boxed_project/http/api_service.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/Login/login_screen.dart';
import 'package:boxed_project/Utility/color_constant.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final String emailId;
  const UpdatePasswordScreen({Key? key, required this.emailId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _newPassword = '';
  String _confirmPassword = '';

  void callResetPasswordApi() async {
  if (!_formKey.currentState!.validate()) {
    return; // Form validation failed, do not proceed.
  }

  _formKey.currentState!.save(); // Save the form fields.

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
      String message = jsonResponse['message'] ?? 'Password updated successfully!';
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        });
      }
    }
  }

  try {
    await ApiService(context).resetPassword(widget.emailId, _newPassword, _confirmPassword, callback);
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
                      'Update Password',
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
                      'Please create new Password',
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
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'New Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Please enter your new password';
                              }
                              if (value!.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                            onSaved: (value) => _newPassword = value ?? "",
                          ),
                          // Confirm Password Field
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value?.isEmpty ?? false) {
                                return 'Please confirm your new password';
                              }
                              if (value != _newPassword) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            onSaved: (value) => _confirmPassword = value ?? "",
                          ),

                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  callResetPasswordApi();
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
                              child: const Text('Update Password'),
                            ),
                          ),

                          const SizedBox(height: 32),
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
