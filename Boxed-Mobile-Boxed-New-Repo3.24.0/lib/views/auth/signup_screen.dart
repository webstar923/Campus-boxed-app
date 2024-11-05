import 'package:animate_do/animate_do.dart';
import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/route_structure/go_router.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';
import 'package:boxed_project/widgets/custom_text_field.dart';
import 'package:boxed_project/widgets/filled_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? check = false;
  bool? check1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: FadeInLeft(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          10.kH,
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: largefontsize5,
                              color: themeblackcolor,
                              fontWeight: boldfontweight,
                            ),
                          ),
                          8.kH,
                          const Text(
                            "Please enter your details",
                            style: TextStyle(
                              fontSize: mediumfontsize4,
                              color: themegreytextcolor,
                            ),
                          ),
                          25.kH,
                          const Text(
                            "Phone Number or Email",
                            style: TextStyle(
                              fontSize: mediumfontsize1,
                              color: themeblackcolor,
                              fontWeight: boldfontweightvar1,
                            ),
                          ),
                          5.kH,
                          const CustomTextField(
                            textInputType: TextInputType.text,
                            hintText: "Enter your Phone Number or Email",
                            isOutlinedInputBorder: true,
                            filled: true,
                            fillColor: themetextfieldcolor,
                            focusedBorderColor: Palette.themecolor,
                            borderWidth: 1.5,
                          ),
                          15.kH,
                          const Text(
                            "Are you a Student or Parent/Family Member",
                            style: TextStyle(
                              fontSize: mediumfontsize1,
                              color: themeblackcolor,
                              fontWeight: boldfontweightvar1,
                            ),
                          ),
                          15.kH,
                          Row(
                            children: [
                              SizedBox(
                                width: 130,
                                child: CheckboxListTile(
                                  activeColor: Palette.themecolor,
                                  contentPadding: EdgeInsets.zero,
                                  checkboxShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  value: check,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      check = value;
                                    });
                                  },
                                  title: const Text(
                                    "Student",
                                    style: TextStyle(
                                      fontSize: mediumfontsize5,
                                      color: themegreytextcolor,
                                      fontWeight: normalfontweightvar1,
                                    ),
                                  ),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                              10.kW,
                              SizedBox(
                                width: 250,
                                child: CheckboxListTile(
                                  activeColor: Palette.themecolor,
                                  contentPadding: EdgeInsets.zero,
                                  checkboxShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  value: check1,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      check1 = value;
                                    });
                                  },
                                  title: const Text(
                                    "Parent/ Family Member",
                                    style: TextStyle(
                                      fontSize: mediumfontsize5,
                                      color: themegreytextcolor,
                                      fontWeight: normalfontweightvar1,
                                    ),
                                  ),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                            ],
                          ),
                          10.kH,
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
                                text: "Already have an account? ",
                                style: const TextStyle(
                                  color: themegreytextcolor,
                                  fontSize: mediumfontsize3,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Go.named(
                                            context,
                                            RouteName.loginScreen,
                                          ),
                                    text: "Sign In",
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
