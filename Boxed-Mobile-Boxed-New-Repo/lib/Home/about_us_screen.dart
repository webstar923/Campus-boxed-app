import 'package:boxed_project/ReservationScreens/reservation_screen.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  double screenWidth = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConstants.primaryColor, //Blue Background
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 122,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            color: const Color(0xFF00307F),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 420,
                    width: screenWidth,
                    child: Image.asset(
                      'assets/images/aboutUs.png', // Image Path for the About Us image
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'We are Boxed Campus Storage',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.primaryBlackColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Your reliable, transparently priced, and stress-free solution to storage. Only serving college students, we provide a valet storage solution to pickup, store, and drop back off your personal items when you are away from Campus. All you do is pack - we provide the boxes and do the rest. From a mobile application to reserve, schedule and pay, to a completely transparent and up-to-date communication line, Boxed Campus Storage is the one-stop shop and premier option for college students and families looking to partner for the summer, or study abroad session. You are 3 clicks and 3 identification questions away from reserving your spot for the summer.',
                          style: TextStyle(
                            fontSize: 16,
                            color: ColorConstants.primaryBlackColor,
                          ),
                        ),
                        const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ReservationScreen()),
                                  );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                foregroundColor: Colors.white, 
                              ),
                              child: const Text('Reserve Now'),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}