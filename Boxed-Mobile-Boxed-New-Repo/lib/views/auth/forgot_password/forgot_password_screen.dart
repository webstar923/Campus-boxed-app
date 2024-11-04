import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';
import 'package:boxed_project/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: themegreytextcolor,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              onTap: () {},
              borderRadius: BorderRadius.circular(30),
              child: const Text(
                "Get OTP",
                style: TextStyle(
                  color: themewhitecolor,
                  fontSize: mediumfontsize3,
                  fontWeight: boldfontweight,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: largefontsize4,
                  fontWeight: boldfontweight,
                ),
              ),
            ),
            10.kH,
            const Center(
              child: Text(
                "Please enter your email address below then we will have you to recover your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: mediumfontsize3,
                  fontWeight: boldfontweightvar1,
                ),
              ),
            ),
            30.kH,
            const Text(
              "Enter Phone Number",
              style: TextStyle(
                fontSize: largefontsize6,
                color: themegreytextcolor,
                fontWeight: boldfontweight,
              ),
            ),
            20.kH,
            const CustomTextField(
              textInputType: TextInputType.text,
              hintText: "Enter Phone Number",
              isOutlinedInputBorder: true,
              filled: true,
              fillColor: themetextfieldcolor,
              focusedBorderColor: Palette.themecolor,
              borderWidth: 1.5,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
