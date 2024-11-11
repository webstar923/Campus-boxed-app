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
import 'package:animate_do/animate_do.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _registerController = UserController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isStudent = false;
  bool _isLoading = false;
  String? selectedSchool = Constants.schoolList.isNotEmpty ? Constants.schoolList[0] : null;

  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });      
      final user = UserModel(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        userType: isStudent ? "2" : "3",
        password: _passwordController.text,
        location: selectedSchool!,
      );

      String responseMessage = await _registerController.registerUser(user);
      setState(() {
        _isLoading = false;
      });   
      if (responseMessage.contains('Register failed')){
        showAnimatedWarningDialog(context, "Register unsuccessful. Try again or cancel.");
      } else {
        showAnimatedWarningDialog(context, "Register unsuccessful. Try again or cancel.");
        Go.named(context, RouteName.loginScreen);
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
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          10.kH,
                          TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: "First Name",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) => value?.isEmpty == true ? "Please enter your first name" : null,
                          ),
                          10.kH,
                          TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: "Last Name",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) => value?.isEmpty == true ? "Please enter your last name" : null,
                          ),
                          10.kH,
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: "Enter your Email",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => value?.isEmpty == true ? "Please enter your email" : null,
                          ),
                          10.kH,
                          TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: "Enter your Phone Number",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) => value?.isEmpty == true ? "Please enter your phone number" : null,
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
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            validator: (value) => value?.isEmpty == true ? "Please enter your password" : null,
                          ),
                          10.kH,
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
                            onTap: _register,
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
                          // Loading indicator overlay
                          5.kH,
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
            ),
          ],
        ),
      ),
    );
  }
}
