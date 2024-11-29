import 'package:flutter/material.dart';
import 'package:boxed_project/models/user_model.dart';
import 'package:boxed_project/controllers/login_controller.dart';
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
import 'package:provider/provider.dart';
import 'package:boxed_project/provider/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController _loginController = LoginController();

  bool visiblePass = true;
  bool _isLoading = false;
  String loginMessage = "";

  void _login() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      UserModel user = UserModel(
        email: emailController.text,
        password: passwordController.text,
      );

      try {
        UserModel? loggedInUser = await _loginController.loginUser(user);
        setState(() {
          _isLoading = false;
        });
        if (loggedInUser != null) {
          Provider.of<AuthProvider>(context, listen: false).login(loggedInUser);
          final storage = FlutterSecureStorage();
          await storage.write(key: 'access_token', value: loggedInUser.token);
          await storage.write(key: 'customer_id', value: loggedInUser.customerId);
          await storage.write(key: 'reservation_exist', value: loggedInUser.reservationExist);
          // String? token = await storage.read(key: 'access_token');
          // Save the user data if needed in the AuthProvider or elsewhere
          if(loggedInUser.reservationExist == 'false')
          {
            Go.named(context, RouteName.reserveNowScreen);
          }
          else
          {
            Go.named(context, RouteName.reserveDetailScreen);
          }
          
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        showAnimatedWarningDialog(context, error.toString());
      }
    }
  }

  void showAnimatedWarningDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SlideInDown(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(7),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.redAccent,
                size: 35,
              ),
              5.kH,
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                side: BorderSide(color: Colors.blue, width: 2), // Set border color and width
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Set border radius
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8), // Add padding
              ),
              child: Text(
                "OK",
                style: TextStyle(color: Colors.blue), // Set text color
              ),
            ),
          ],
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Go.named(context, RouteName.welcomeScreen);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
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
                                "Email",
                                style: TextStyle(
                                  fontSize: mediumfontsize1,
                                  color: themeblackcolor,
                                  fontWeight: boldfontweightvar1,
                                ),
                              ),
                              5.kH,
                              CustomTextField(
                                controller: emailController,
                                textInputType: TextInputType.text,
                                hintText: "Enter your email",
                                isOutlinedInputBorder: true,
                                filled: true,
                                fillColor: themetextfieldcolor,
                                focusedBorderColor: Palette.themecolor,
                                borderWidth: 1.5,
                                autoFocus: true,
                                validator: (value) => value!.isEmpty ? "Enter email" : null,
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
                                controller: passwordController,
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
                                validator: (value) => value!.isEmpty ? "Enter password" : null,
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
                                onTap: _login,
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
                              // Loading indicator overlay
                              10.kH,
                              if (_isLoading)
                                Container(
                                  color: Colors.black.withOpacity(0),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              30.kH,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 100,
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
                                    width: 100,
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
        ),
      ),
    );
  }
}
