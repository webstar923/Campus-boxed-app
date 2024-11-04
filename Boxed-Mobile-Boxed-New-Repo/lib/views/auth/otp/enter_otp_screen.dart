// import 'package:boxed_project/route_structure/go_navigator.dart';
// import 'package:boxed_project/route_structure/go_router.dart';
// import 'package:boxed_project/theme/colors.dart';
// import 'package:boxed_project/theme/font_structures.dart';
// import 'package:boxed_project/widgets/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';

// class EnterOtpScreen extends StatefulWidget {
//   const EnterOtpScreen({super.key});

//   @override
//   State<EnterOtpScreen> createState() => _EnterOtpScreenState();
// }

// class _EnterOtpScreenState extends State<EnterOtpScreen> {
//   var code = "";
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final defaultPinTheme = PinTheme(
//       width: size.width / 100 * 18,
//       height: 80,
//       textStyle: const TextStyle(
//         fontSize: largefontsize5,
//         color: Palette.themecolor,
//         fontWeight: boldfontweightvar2,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         border: Border.all(color: themegreycolor),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );
//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: Palette.themecolor),
//       borderRadius: BorderRadius.circular(20),
//     );

//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration?.copyWith(
//         color: Palette.themecolor.withOpacity(0.9),
//       ),
//       textStyle: const TextStyle(
//         fontSize: largefontsize5,
//         color: themewhitecolor,
//         fontWeight: FontWeight.w600,
//       ),
//     );
//     // final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 "assets/images/png/otp-code.png",
//                 height: 300,
//                 fit: BoxFit.cover,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(40.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Enter your OTP code",
//                       style: TextStyle(
//                         fontSize: largefontsize5,
//                         fontWeight: boldfontweight,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       "We just send you a verification code via phone\n+92 311 1515151",
//                       style: TextStyle(
//                         fontSize: mediumfontsize4,
//                         fontWeight: normalfontweightvar4,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Center(
//                       child: Pinput(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         length: 4,
//                         defaultPinTheme: defaultPinTheme,
//                         focusedPinTheme: focusedPinTheme,
//                         submittedPinTheme: submittedPinTheme,
//                         onChanged: (value) {
//                           code = value;
//                         },
//                         showCursor: true,
//                         // ignore: avoid_print
//                         onCompleted: (pin) => print(pin),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Center(
//                       child: CustomButton(
//                         onTap: () {
//                           Go.namedReplace(
//                             context,
//                             RouteName.navbar,
//                             params: {
//                               'currentIndex': "0",
//                             },
//                           );
//                         },
//                         height: 60,
//                         width: double.infinity,
//                         buttoncolor: Palette.themecolor,
//                         borderRadius: BorderRadius.circular(30),
//                         child: const Text(
//                           "Verify",
//                           style: TextStyle(
//                             color: themewhitecolor,
//                             fontSize: mediumfontsize1,
//                             fontWeight: boldfontweightvar1,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     const Center(
//                       child: Text.rich(
//                         TextSpan(
//                             text: "Didn’t receive the code? ",
//                             style: TextStyle(
//                               fontSize: mediumfontsize4,
//                               fontWeight: normalfontweightvar4,
//                             ),
//                             children: [
//                               TextSpan(
//                                 // recognizer: TapGestureRecognizer()
//                                 //   ..onTap = () => RouteNavigator.route(
//                                 //         context,
//                                 //         const LoginScreen(),
//                                 //       ),
//                                 text: "Resend",
//                                 style: TextStyle(
//                                   color: Palette.themecolor,
//                                   fontSize: mediumfontsize3,
//                                   fontWeight: boldfontweight,
//                                 ),
//                               ),
//                             ]),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
