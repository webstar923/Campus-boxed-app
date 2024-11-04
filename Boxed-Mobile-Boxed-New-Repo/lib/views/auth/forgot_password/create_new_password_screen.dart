// import 'package:ecommerce_app/navigator.dart';
// import 'package:ecommerce_app/provider/dark_theme_provider.dart';
// import 'package:ecommerce_app/theme/colors.dart';
// import 'package:ecommerce_app/views/navigation/bottom_nav_bar.dart';
// import 'package:ecommerce_app/widgets/custom_rounded_button.dart';
// import 'package:ecommerce_app/widgets/custom_simple_rounded_button.dart';
// import 'package:ecommerce_app/widgets/text_field_input.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';

// class CreateNewPasswordScreen extends StatefulWidget {
//   const CreateNewPasswordScreen({Key? key}) : super(key: key);

//   @override
//   State<CreateNewPasswordScreen> createState() =>
//       _CreateNewPasswordScreenState();
// }

// class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmpasswordController =
//       TextEditingController();
//   int? selectedIndex;
//   bool? check = false;
//   @override
//   Widget build(BuildContext context) {
//     final themeChange = Provider.of<DarkThemeProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(
//           "Create New Password",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 10.0),
//         child: CustomRoundedButton(
//           buttonText: "Continue",
//           onTap: () {
//             showAnimatedDialog(
//                 barrierDismissible: true,
//                 animationType: DialogTransitionType.slideFromRight,
//                 curve: Curves.fastOutSlowIn,
//                 duration: const Duration(milliseconds: 700),
//                 context: context,
//                 builder: (context) => StatefulBuilder(
//                       builder: (context, setState) => AlertDialog(
//                         shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         titlePadding: const EdgeInsets.all(24),
//                         actionsPadding: const EdgeInsets.all(0),
//                         buttonPadding: const EdgeInsets.all(0),
//                         title: Column(
//                           children: [
//                             Column(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: themeblackcolor,
//                                   radius: 50,
//                                   child: Icon(
//                                     Icons.check,
//                                     color: Palette.themecolor,
//                                     size: 50,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Text(
//                                   'Congratulations!',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             Text(
//                               "Your account is ready to use. You will be redirected to Home page in a few seconds",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(fontSize: 13),
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             CustomSimpleRoundedButton(
//                                 buttonText: "Continue",
//                                 onTap: () {
//                                   RouteNavigator.pushandremoveroute(context, BottomNavBar());
//                                 },
//                                 height: kMinInteractiveDimension,
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.60,
//                                 buttoncolor: themegreycolor,
//                                 buttontextcolor: themeblackcolor),
//                           ],
//                         ),
//                       ),
//                     ));
//           },
//           buttoncolor: themeChange.darkTheme == true
//               ? themegreycolor
//               : themeChange.darkTheme == false
//                   ? themeblackcolor
//                   : Palette.themecolor,
//           buttontextcolor: themeChange.darkTheme == true
//               ? themeblackcolor
//               : themeChange.darkTheme == false
//                   ? Palette.themecolor
//                   : Palette.themecolor,
//           height: kMinInteractiveDimension,
//           width: MediaQuery.of(context).size.width * 0.80,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               Center(
//                 child: SvgPicture.asset(
//                   "assets/images/svg/change_password.svg",
//                   height: 200,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Text(
//                   "Create Your New Password",
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextFieldInput(
//                 textEditingController: passwordController,
//                 hintText: "Password",
//                 textInputType: TextInputType.emailAddress,
//                 isPass: true,
//                 icon: const Icon(
//                   Icons.lock,
//                   color: Colors.grey,
//                   size: 20,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               TextFieldInput(
//                 textEditingController: confirmpasswordController,
//                 hintText: "Confirm Password",
//                 textInputType: TextInputType.emailAddress,
//                 isPass: true,
//                 icon: const Icon(
//                   Icons.lock,
//                   color: Colors.grey,
//                   size: 20,
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Row(
//                 children: [
//                   Checkbox(
//                     checkColor: themeChange.darkTheme == true
//                         ? themeblackcolor
//                         : themeChange.darkTheme == false
//                             ? Palette.themecolor
//                             : null,
//                     activeColor: themeChange.darkTheme == true
//                         ? Palette.themecolor
//                         : themeChange.darkTheme == false
//                             ? themeblackcolor
//                             : null,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     value: check,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         check = value;
//                       });
//                     },
//                   ),
//                   const Text(
//                     "Remember me",
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
