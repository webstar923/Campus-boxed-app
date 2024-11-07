import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/widgets/filled_box.dart';
import 'package:flutter/material.dart';

class CardTrusted extends StatefulWidget {
  final double width;
  final String image;
  final String title;
  final String subtitle;
  const CardTrusted({
    super.key,
    this.width = 120,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  State<CardTrusted> createState() => _CardTrustedState();
}

class _CardTrustedState extends State<CardTrusted> {
  @override
  Widget build(BuildContext context) {
    return FilledBox(
      width: widget.width,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(1),
      color: themewhitecolor,
      border: Border.all(color: Palette.themecolor),
      boxShadow: const [
        BoxShadow(
          blurRadius: 2,
          color: Palette.themecolor,
          offset: Offset(5, 7),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              widget.image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            10.kH,
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 22,
                color: Palette.themecolor,
                fontWeight: normalfontweightvar1,
              ),
            ),
            10.kH,
            Text(
              widget.subtitle,
              // textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: normalfontweightvar1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
