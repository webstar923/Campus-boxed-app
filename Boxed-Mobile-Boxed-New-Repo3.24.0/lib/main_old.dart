import 'package:boxed_project/route_structure/go_router.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:boxed_project/ReservationScreens/reservation_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReservationScreen(), // Your reservation screen as the home widget
    );
  }
}