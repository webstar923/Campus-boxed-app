import 'dart:convert';

import 'package:boxed_project/Home/home_view.dart';
import 'package:boxed_project/Utility/common.dart';
import 'package:boxed_project/Utility/loading.dart';
import 'package:boxed_project/Utility/preference_helper.dart';
import 'package:boxed_project/common/base_widget.dart';
import 'package:boxed_project/http/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:boxed_project/TabBar/tabbar_screen.dart';
import 'package:boxed_project/Login/sign_up_screen.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/Login/forget_password_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef ResponseCallback = void Function(String responseBody);


void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor:
        Colors.transparent, // Set this to transparent to see the native color
    statusBarIconBrightness:
        Brightness.light, // Set the status bar icons to light
  ));
  runApp(MaterialApp(home: LoginScreen()));
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final PreferencesHelper _preferencesHelper = PreferencesHelper();
  // User? _user;
  bool _showPassword = false;
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKey;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  Connectivity connectivity = Connectivity();
  String token = "";

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

  }

  @override
  void dispose() {
    _usernameController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }
  
  Future<void> login(BuildContext context) async {
  showLoadingDialog(context);

  void callback(String responseBody, {bool isError = false}) {
    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
    if (isError) {
      String message = jsonResponse['error'] ?? 'Something went Wrong';
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
      String message = jsonResponse['message'] ?? 'Login successful!';
      String token = jsonResponse['data']['token'];
      storeAdminToken(token);

      if (mounted) {
        setState(() {
          hideLoadingDialog(context);
          _preferencesHelper.isLoggedIn = 1;
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
            MaterialPageRoute(builder: (context) =>  const TabBarScreen()),
          );
        });
      }
    }
  }

  await ApiService(context).userLogin(
    _usernameController!.text.toString(),
    _passwordController!.text.toString(),
    callback,
  );
}

  Future<void> storeAdminToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('adminToken', token);
  }

  Future<String?> getAdminToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('adminToken');
  }


  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TabBarScreen(),
          ),
        );
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error during Google Sign-In: $error');
      }
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
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding:
                    EdgeInsets.zero, // Ensure ListView starts from the very top
                children: [
                  Container(
                    height: 140 +
                        MediaQuery.of(context)
                            .padding
                            .top, // Add status bar height to the container height
                    color: ColorConstants
                        .primaryColor, // Fixed height for the top space
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                        child: Image.asset(
                          'assets/images/boxed_logo.png',
                          height: 67,
                          width: 212,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Sign In',
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
                      'Welcome Back, You\'ve been missed.',
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
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              hintText: 'Enter your Password',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                const ();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPasswordScreen()),
                                );
                              },
                              child: const Text('Forgot password?'),
                            ),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey!.currentState!.validate()) {
                                 login(context);
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
                              child: const Text('Sign In'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 1.0,
                                    color: ColorConstants.primarygreyColor,
                                  ),
                                ),
                                const Text(
                                  'Sign In with',
                                  style: TextStyle(
                                    color: ColorConstants.primarygreyColor,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1.0,
                                    color: ColorConstants.primarygreyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: _handleGoogleSignIn,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: ColorConstants
                                            .primaryLightGreyColor,
                                        width: 1), // Grey border
                                  ),
                                  child: CircleAvatar(
                                    radius:
                                        24, // Half of the height/width for a circle
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                      'assets/images/google_logo.png',
                                      height: 16, // Smaller image size
                                      width: 16, // Smaller image size
                                      fit: BoxFit
                                          .contain, // Ensures the image fits well inside the CircleAvatar
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color:
                                          ColorConstants.primaryLightGreyColor,
                                      width: 1), // Grey border
                                ),
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    'assets/images/facebook_logo.png',
                                    height: 16,
                                    width: 16,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color:
                                          ColorConstants.primaryLightGreyColor,
                                      width: 1), // Grey border
                                ),
                                child: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    'assets/images/apple_logo.png',
                                    height: 16,
                                    width: 16,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()),
                                );
                              },
                              child: const Text(
                                'Don\'t have an account? Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
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
