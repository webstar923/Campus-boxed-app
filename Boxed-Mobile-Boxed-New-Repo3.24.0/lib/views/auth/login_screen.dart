import 'package:animate_do/animate_do.dart';
import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/route_structure/go_router.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';
import 'package:boxed_project/widgets/custom_text_button.dart';
import 'package:boxed_project/widgets/custom_text_field.dart';
import 'package:boxed_project/widgets/filled_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool visiblePass = true;
  bool? check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            FilledBox(
              height: 250,
              width: double.infinity,
              padding: EdgeInsets.zero,
              image: const DecorationImage(
                image: AssetImage(
                  "assets/images/background.png",
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Constants.splashLogo,
                    width: 350,
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
                    child: FadeInRight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.kH,
                          const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: largefontsize5,
                              color: themeblackcolor,
                              fontWeight: boldfontweight,
                            ),
                          ),
                          8.kH,
                          const Text(
                            "Welcome Back, You’ve been missed.",
                            style: TextStyle(
                              fontSize: mediumfontsize4,
                              color: themegreytextcolor,
                            ),
                          ),
                          25.kH,
                          const Text(
                            "Username",
                            style: TextStyle(
                              fontSize: mediumfontsize1,
                              color: themeblackcolor,
                              fontWeight: boldfontweightvar1,
                            ),
                          ),
                          5.kH,
                          const CustomTextField(
                            textInputType: TextInputType.text,
                            hintText: "Enter your username",
                            isOutlinedInputBorder: true,
                            filled: true,
                            fillColor: themetextfieldcolor,
                            focusedBorderColor: Palette.themecolor,
                            borderWidth: 1.5,
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
                          5.kH,
                          CustomTextField(
                            textInputType: TextInputType.text,
                            hintText: "Password",
                            isOutlinedInputBorder: true,
                            filled: true,
                            fillColor: themetextfieldcolor,
                            focusedBorderColor: Palette.themecolor,
                            borderWidth: 1.5,
                            obscureText: visiblePass,
                            suffix: CustomIconButton(
                              onTap: () {
                                setState(() {
                                  visiblePass = !visiblePass;
                                });
                              },
                              child: Icon(
                                visiblePass == false
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Palette.themecolor,
                              ),
                            ),
                          ),
                          10.kH,
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomTextButton(
                              buttonText: "Forgot Password?",
                              buttonTextStyle: const TextStyle(
                                color: Palette.themecolor,
                                fontSize: mediumfontsize3,
                                fontWeight: boldfontweight,
                              ),
                              onTap: () {
                                Go.named(
                                  context,
                                  RouteName.forgotPasswordScreen,
                                );
                              },
                            ),
                          ),
                          25.kH,
                          CustomButton(
                            onTap: () {
                              Go.namedReplace(
                                context,
                                RouteName.navbar,
                                params: {
                                  'currentIndex': "0",
                                },
                              );
                            },
                            height: 55,
                            borderRadius: BorderRadius.circular(10),
                            child: const Text(
                              "Sign in",
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
                              const SizedBox(
                                width: 140,
                                child: Divider(
                                  thickness: 1,
                                  color: themegreytextcolor,
                                ),
                              ),
                              10.kW,
                              const Text(
                                "Sign in with",
                                style: TextStyle(
                                  fontSize: mediumfontsize3,
                                  color: themegreytextcolor,
                                ),
                              ),
                              10.kW,
                              const SizedBox(
                                width: 140,
                                child: Divider(
                                  thickness: 1,
                                  color: themegreytextcolor,
                                ),
                              ),
                            ],
                          ),
                          20.kH,
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
                            ],
                          ),
                          20.kH,
                          Align(
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(
                                text: "Don't have an account? ",
                                style: const TextStyle(
                                  color: themegreytextcolor,
                                  fontSize: mediumfontsize3,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Go.named(
                                            context,
                                            RouteName.signupScreen,
                                          ),
                                    text: "Sign Up",
                                    style: const TextStyle(
                                      color: Palette.themecolor,
                                      fontSize: mediumfontsize1,
                                      fontWeight: FontWeight.bold,
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
