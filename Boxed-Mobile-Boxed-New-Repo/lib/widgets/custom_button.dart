import 'package:boxed_project/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final Color? buttoncolor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Gradient? buttongradientColor;
  const CustomButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.height = 50,
    this.width = double.infinity,
    this.buttoncolor = Palette.themecolor,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(8),
    ),
    this.border,
    this.buttongradientColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttoncolor,
          borderRadius: borderRadius,
          gradient: buttongradientColor,
          border: border,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
