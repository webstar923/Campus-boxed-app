import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/route_structure/go_router.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:boxed_project/widgets/filled_box.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FilledBox(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.zero,
          image: const DecorationImage(
            image: AssetImage(
              "assets/images/background.png",
            ),
            fit: BoxFit.cover,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                Constants.splashLogo,
                width: 350,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50, left: 15, right: 15),
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onTap: () {
                          Go.named(
                            context,
                            RouteName.signupScreen,
                          );
                        },
                        height: 60,
                        buttoncolor: themewhitecolor,
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: mediumfontsize1,
                            color: Palette.themecolor,
                            fontWeight: boldfontweight,
                          ),
                        ),
                      ),
                      15.kH,
                      CustomButton(
                        onTap: () {
                          Go.named(
                            context,
                            RouteName.loginScreen,
                          );
                        },
                        height: 60,
                        buttoncolor: Colors.transparent,
                        border: Border.all(color: themewhitecolor),
                        child: const Text(
                          "Have an account? Login",
                          style: TextStyle(
                            fontSize: mediumfontsize1,
                            color: themewhitecolor,
                            fontWeight: boldfontweight,
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
      ),
    );
  }
}
