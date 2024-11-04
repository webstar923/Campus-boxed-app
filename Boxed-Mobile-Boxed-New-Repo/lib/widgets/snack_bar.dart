import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:flutter/material.dart';

void showSnackBar(context, String message) {
  final snackBar = SnackBar(
    backgroundColor: Palette.themecolor,
    duration: const Duration(milliseconds: 1500),
    content: Text(
      message,
      style: const TextStyle(
        color: themewhitecolor,
        fontWeight: boldfontweight,
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
