import 'dart:async';
import 'package:boxed_project/utils/constants.dart';
import 'package:boxed_project/widgets/filled_box.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/route_structure/go_router.dart';
import 'package:boxed_project/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Go.namedReplace(
          context,
          RouteName.welcomeScreen,
        );
      },
    );
  }

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
              const Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: CircularProgressIndicator(
                    color: themewhitecolor,
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
