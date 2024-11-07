import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SelfMove extends StatefulWidget {

  @override
  State<SelfMove> createState() => _SelfMove();
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0); 
    path.lineTo(0, 0);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _SelfMove extends State<SelfMove> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.kH,
        Container(
          color: const Color.fromARGB(255, 1, 33, 104), // Background color of the container
          child: Center(
            child: Column(
              children: [
                // Wave SVG effect
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 30, // Adjust the height as needed
                    color: Colors.white, // Color of the wave effect
                  ),
                ),
                30.kH,
                const Text(
                  "Have the Easiest Move of\nYour Life with Boxed\nCampus Storage!",
                  style: TextStyle(
                    fontSize: largefontsize5,
                    color: Colors.white,
                    fontWeight: boldfontweight,
                  ),
                  textAlign: TextAlign.center,
                ),
                25.kH,
                const Text(
                  "Reserve with us to secure your summer storage needs! We are here to assist you through the big transitions of your college journey.",
                  style: TextStyle(
                    fontSize: mediumfontsize3,
                    color: Colors.grey,
                    fontWeight: boldfontweight,
                  ),
                  textAlign: TextAlign.center,
                ),
                50.kH
              ],
            ),
          ),
        ),
      ],
    );
  }
}
