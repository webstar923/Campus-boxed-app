// views/signup_screen.dart
// import 'dart:ui_web';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/models/user_sign_up_model.dart';
import 'package:boxed_project/controllers/user_controller.dart';
import 'package:boxed_project/widgets/filled_box.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/route_structure/go_router.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _userController = UserController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isStudent = false;

  // Initialize selectedSchool with the first element in Constants.schoolList
  String? selectedSchool = Constants.schoolList.isNotEmpty ? Constants.schoolList[0] : null;

  void _register() {
    final user = UserModel(
      email: _emailController.text,
      phone: _phoneController.text,
      userType: isStudent ? "2" : "3",
      password: _passwordController.text,
      location: selectedSchool!,
    );
    _userController.registerUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none, 
          children: [
            FilledBox(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.zero,
              image: const DecorationImage(
                image: AssetImage(
                  "assets/images/background.png",
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50, left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomIconButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: themewhitecolor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  5.kH,
                  Image.asset(
                    Constants.splashLogo,
                    width: 300,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 220),
              child: FilledBox(
                width: double.infinity,
                color: themewhitecolor,
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),              
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        10.kH,
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "Enter your Email",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        10.kH,
                        TextField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: "Enter your Phone Number",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        10.kH,
                        Row(
                          children: [
                            Checkbox(
                              value: isStudent,
                              onChanged: (value) {
                                setState(() {
                                  isStudent = value ?? false;
                                });
                              },
                            ),
                            const Text("Student"),
                            Checkbox(
                              value: !isStudent,
                              onChanged: (value) {
                                setState(() {
                                  isStudent = !(value ?? true);
                                });
                              },
                            ),
                            const Text("Parent/Family"),
                          ],
                        ),
                        20.kH,
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        10.kH,
                        
                        // School Dropdown
                        DropdownButtonFormField<String>(
                          value: selectedSchool,
                          items: Constants.schoolList.map((school) {
                            return DropdownMenuItem(
                              value: school,
                              child: Text(school),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSchool = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: "School",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        
                        20.kH,
                        CustomButton(
                          onTap: () {
                            _register();
                          },
                          height: 55,
                          borderRadius: BorderRadius.circular(10),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: themewhitecolor,
                              fontSize: mediumfontsize3,
                              fontWeight: boldfontweight,
                            ),
                          ),
                        ),
                        30.kH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledBox(
                              height: 50,
                              width: 50,
                              shape: BoxShape.circle,
                              padding: const EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.transparent,
                              border: Border.all(
                                color: themegreytextcolor,
                              ),
                              child: Image.asset(
                                "assets/images/google_logo.png",
                              ),
                            ),
                            15.kW,
                            FilledBox(
                              height: 50,
                              width: 50,
                              shape: BoxShape.circle,
                              padding: const EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.transparent,
                              border: Border.all(
                                color: themegreytextcolor,
                              ),
                              child: Image.asset(
                                "assets/images/facebook_logo.png",
                              ),
                            ),
                            15.kW,
                            FilledBox(
                              height: 50,
                              width: 50,
                              shape: BoxShape.circle,
                              padding: const EdgeInsets.all(8),
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.transparent,
                              border: Border.all(
                                color: themegreytextcolor,
                              ),
                              child: Image.asset(
                                "assets/images/apple_logo.png",
                              ),
                            ),                    
                            // IconButton(
                            //   onPressed: () {
                            //     // Implement Google sign-in
                            //   },
                            //   icon: Image.asset("assets/images/google_logo.png"),
                            // ),
                            // IconButton(
                            //   onPressed: () {
                            //     // Implement Facebook sign-in
                            //   },
                            //   icon: Image.asset("assets/images/facebook_logo.png"),
                            // ),
                            // IconButton(
                            //   onPressed: () {
                            //     // Implement Apple sign-in
                            //   },
                            //   icon: Image.asset("assets/images/apple_logo.png"),
                            // ),
                          ],
                        ),
                        20.kH,
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account? ",
                              style: const TextStyle(
                                color: themegreytextcolor,
                                fontSize: mediumfontsize3,
                              ),
                              children: [
                                TextSpan(                         
                                  text: "Sign In",
                                  style: const TextStyle(
                                    color: Palette.themecolor,
                                    fontSize: mediumfontsize1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Go.named(
                                        context,
                                        RouteName.loginScreen,
                                      );
                                    },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
