import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class Servey extends StatefulWidget {

  @override
  State<Servey> createState() => _Servey();
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 6); // Start the path at the top-left corner
    path.lineTo(0, 0); // Draw the line vertically down a bit

    // Draw a straight line across the top
    path.lineTo(size.width, 0);
    
    // Draw a slanting line down to form the wave effect
    path.lineTo(0, size.height * 1);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _Servey extends State<Servey> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white, // Background color of the container
          child: Center(
            child: Column(
              children: [
                10.kH,
                // Wave SVG effect
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 30, // Adjust the height as needed
                    color: const Color.fromARGB(255, 1, 33, 104), // Color of the wave effect
                  ),
                ),
                30.kH,
                const Text(
                  "Do our Questionnaire for a",
                  style: TextStyle(
                    fontSize: mediumfontsize1,
                    color: Palette.themecolor,
                    fontWeight: boldfontweight,
                  ),
                ),
                10.kH,
                const Text(
                  "\$5 Amazon Gift Card!",
                  style: TextStyle(
                    fontSize: largefontsize5,
                    color: Palette.themecolor,
                    fontWeight: boldfontweight,
                  ),
                ),
                20.kH,
                CustomButton(
                  onTap: () {},
                  height: 45,
                  width: 200,
                  buttoncolor: Colors.transparent,
                  borderRadius: BorderRadius.circular(1),
                  border: Border.all(color: Palette.themecolor),
                  child: const Text(
                    "Surveys",
                    style: TextStyle(
                      fontSize: mediumfontsize1,
                      color: Palette.themecolor,
                      fontWeight: boldfontweight,
                    ),
                  ),
                ),
                20.kH,
                Icon(
                  Icons.play_circle,
                  color:Palette.themecolor.withOpacity(0.7), // Adjust color as needed
                  size: 50,
                ),
                35.kH
              ],
            ),
          ),
        ),
      ],
    );
  }
}
