import 'dart:convert';

import 'package:boxed_project/Login/get_start_screen.dart';
import 'package:boxed_project/Login/login_screen.dart';
import 'package:boxed_project/Utility/preference_helper.dart';
import 'package:boxed_project/common/base_widget.dart';
import 'package:boxed_project/http/api_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/Notification/notification_view.dart';
import 'package:boxed_project/ReservationScreens/reservation_details_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final String surveyUrl =
      "https://docs.google.com/forms/d/e/1FAIpQLSc5UEn8ABn4cEoiGaHrKIk0FW1hudyajbogkE9u3XNzJRP7vg/viewform";
  final String videoUrl =
      "https://boxedstorage.org/wp-content/uploads/2024/04/Home-Video-2.mp4";
  List<String> imageUrls = [];
  final prefs = PreferencesHelper();

  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    fetchImages();
  });
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
}

// Method to fetch images
Future<void> fetchImages() async {
  showLoadingDialog(context);

  void callback(String responseBody, {bool isError = false}) {
    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

    if (isError) {
      String message = jsonResponse['error'] ?? 'Something went wrong';
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          hideLoadingDialog(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    } else {
      List<dynamic> data = jsonResponse['data'];
      String message = jsonResponse['message'] ?? 'Data fetched successfully!';
      
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            imageUrls = data.map((item) => item['image'] as String).toList();
          });
          hideLoadingDialog(context);
        });
      }
    }
  }

  await ApiService(context).getBannerImages(callback);
}

// Method to handle logout
Future<void> _logout(BuildContext context) async {
  showLoadingDialog(context);

  void callback(String responseBody, {bool isError = false}) {
    Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
    if (isError) {
      String message = jsonResponse['error'] ?? 'Something went wrong';
      hideLoadingDialog(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Handle successful response
      String message = jsonResponse['message'] ?? 'Logout successful!';
      if (mounted) {
        setState(() {
          hideLoadingDialog(context);
          prefs.isLoggedIn = 0; // Set isLoggedIn to 0 (false) on logout
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MaterialApp(
                debugShowCheckedModeBanner: false,
                home: GetStartScreen(),
              ),
            ),
            (Route<dynamic> route) => false,
          );
        });
      }
    }
  }
  await ApiService(context).userLogout(callback);
}

  void _navigateToNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotficationView()),
    );
  }

  void _showLoginPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Required'),
          content: const Text('Please log in to access this feature.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
  // Show the confirmation dialog
  final bool? shouldLogout = await showDialog<bool>(
    context: context,
    barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Return false if "No" is pressed
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Return true if "Yes" is pressed
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );

  if (shouldLogout == true) {
    await _logout(context);
  }
}

  @override
  Widget build(BuildContext context) {
    // final user = widget.user;
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 80 + MediaQuery.of(context).padding.top,
          color: ColorConstants.primaryColor,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Image.asset(
                    'assets/images/boxed_logo.png',
                    height: 62,
                    width: 208,
                  ),
                ),
              ),
              Positioned(
                bottom: 20.0,
                right: 20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _navigateToNotification,
                      child: const Icon(
                        Icons.notifications,
                        color: ColorConstants.primaryWhiteColor,
                      ),
                    ),
                    const SizedBox(width: 16), // Add some space between the icons
                    GestureDetector(
                      onTap: () => _showLogoutConfirmationDialog(context),
                      child: const Icon(
                        Icons.logout,
                        color: ColorConstants.primaryWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      color: const Color(0xFF002366), // Blue background color
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          SizedBox(
                            height: 380,
                            child: imageUrls.isEmpty
                                ? Center(child: Image.asset('assets/images/banner1.png'))
                                : PageView.builder(
                                    controller: PageController(viewportFraction: 0.8),
                                    onPageChanged: (page) {
                                      setState(() {
                                        _currentPage = page;
                                      });
                                    },
                                    itemCount: imageUrls.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Image.network(imageUrls[index]),
                                      );
                                    },
                                  ),
                          ),
                          const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < imageUrls.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: _currentPage == i
                                        ? Image.asset(
                                            'assets/images/selectedpage.png',
                                            width: 30,
                                            height: 9)
                                        : Image.asset(
                                            'assets/images/notselectedpage.png',
                                            width: 7,
                                            height: 5),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 7),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50.0),
                              child: SizedBox(
                                width: double
                                    .infinity, 
                                child: ElevatedButton(
                                  onPressed: () {
                                  if (prefs.isLoggedIn == 1) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ReservationDetailScreen()), // Replace with your next screen
                                    );
                                  } else {
                                     _showLoginPopup(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  backgroundColor:
                                      Colors.white, // Button text color
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0), // Button padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        4.0), // Rounded corners
                                    // Border color
                                  ),
                                ),
                                child: const Text(
                                  'Reserve Now',
                                  style: TextStyle(
                                      fontSize: 16.0, // Text size
                                      fontWeight:
                                          FontWeight.w500, // Text weight
                                      color: Color.fromRGBO(1, 33, 105, 1)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                    color: const Color.fromARGB(
                        1, 248, 250, 255), // Blue background color
                    child: Column(children: [
                      const SizedBox(height: 20),
                      const Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Align(
                              alignment: Alignment
                                  .centerLeft, // align text to the left
                              child: Text(
                                'How We Work',
                                style: TextStyle(
                                    fontSize: 20.0, // Text size
                                    fontWeight: FontWeight.w600, // Text weight
                                    color: Color.fromRGBO(1, 33, 105, 1)),
                              ))),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildStepCard(
                                icon: Image.asset(
                                  'assets/images/reserve1.png', // Replace with your first icon path
                                  height: 26,
                                  width: 30,
                                ),
                                title: 'Reserve your Spot',
                                description:
                                    'Reserve your spot today and enjoy hassle-free summer storage solutions for college students. From pickup to drop-off, Boxed has you covered every step of the way.',
                                isTextSpan: false),
                            _buildStepCard(
                              icon: Image.asset(
                                'assets/images/reserve2.png', // Replace with your first icon path
                                height: 26,
                                width: 30,
                              ),
                              title: 'Pack your Items',
                              description:
                                  'Prior to your pickup date, Boxed will provide you with complementary moving materials, including our ',
                              isTextSpan: true,
                            ),
                            _buildStepCard(
                                icon: Image.asset(
                                  'assets/images/reserve3.png', // Replace with your first icon path
                                  height: 26,
                                  width: 30,
                                ),
                                title: 'Receive Your College Cart',
                                description:
                                    'We reduce the friction of your move by providing the materials you need on pickup day, including our easy-to-use COLLEGE CART that can fit 25 cubic feet of goods.',
                                isTextSpan: false),
                            _buildStepCard(
                                icon: Image.asset(
                                  'assets/images/reserve4.png', // Replace with your first icon path
                                  height: 26,
                                  width: 30,
                                ),
                                title: 'Contact Us for Drop-Off',
                                description:
                                    'Ready to receive your belongings? Boxed will ensure you have a seamless transition back from summer break with our convenient and reliable service.',
                                isTextSpan: false),
                            const SizedBox(height: 20),
                            const Text(
                              'Do our Questionnaire for a',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(1, 33, 105, 1),
                                wordSpacing: 0.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              '\$5 Amazon Gift Card!',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(1, 33, 105, 1),
                                wordSpacing: 0.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            OutlinedButton(
                              onPressed: () async {
                                if (await canLaunch(surveyUrl)) {
                                  await launch(surveyUrl);
                                } else {
                                  throw 'Could not launch $surveyUrl';
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      0.0), // Rounded corners
                                  // Border color
                                ),
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    const Color.fromRGBO(1, 33, 105, 1),
                                side: const BorderSide(
                                    color: Color.fromRGBO(
                                        1, 33, 105, 1)), // Border color
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 65.0, vertical: 17.0),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              child: const Text('Survey'),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                                height: 107,
                                width: 107,
                                child: IconButton(
                                    icon: Image.asset("assets/images/play.png"),
                                    onPressed: () async {
                                      // ignore: deprecated_member_use
                                      if (await canLaunch(videoUrl)) {
                                        // ignore: deprecated_member_use
                                        if (await canLaunch(videoUrl)) {
                                          // ignore: deprecated_member_use
                                          await launch(videoUrl);
                                        } else {
                                          throw 'Could not launch $videoUrl';
                                        }
                                      }
                                      ;
                                    })),
                            const SizedBox(height: 60),
                          ],
                        ),
                      )
                    ])),
              ],
            ),
          ),
        ),
        Container(
            color: const Color.fromARGB(255, 246, 242, 242),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              width: MediaQuery.of(context).size.width,
              height: 100, // Container height
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top two labels with text size 8
                  const SizedBox(height: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Set a reminder to sign up for storage!',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          )),
                      const SizedBox(height: 1.0),
                      const Text(
                        "We'll remind you to sign up when it gets closer to your winter and summer back!",
                        style: TextStyle(fontSize: 9.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 3.0), // Space between labels and fields

                  // Email and phone number fields with button
                  Row(
                    children: [
                      // Email Field
                      const Expanded(
                        child: SizedBox(
                          height: 30, // Height of the field
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                                fontSize: 12), // Adjust font size as needed
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0), // Space between fields

                      // Phone Number Field
                      const Expanded(
                        child: SizedBox(
                          height: 30, // Height of the field
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Phone number',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                                fontSize: 12), // Adjust font size as needed
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0), // Space between fields

                      // Button
                      SizedBox(
                        width: 60, // Button width
                        height: 30, // Button height to match fields
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your button logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.primaryColor,
                            padding: EdgeInsets.zero,
                            textStyle: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.primaryWhiteColor),
                          ),
                          child: const Text('Submit',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstants.primaryWhiteColor)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))
      ],
    ));
  }

  Widget _buildStepCard(
      {required Image icon,
      required String title,
      required String description,
      required bool isTextSpan}) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(
                      1, 33, 105, 1), // Set the color of the bottom border
                  width: 5.0, // Set the width of the bottom border
                ),
                left: BorderSide(
                  color: Color.fromRGBO(
                      1, 33, 105, 1), // Set the color of the left border
                  width: 1.0, // Set the width of the left border
                ),
                right: BorderSide(
                  color: Color.fromRGBO(
                      1, 33, 105, 1), // Set the color of the left border
                  width: 5.0, // Set the width of the left border
                ),
                top: BorderSide(
                  color: Color.fromRGBO(
                      1, 33, 105, 1), // Set the color of the left border
                  width: 1.0, // Set the width of the left border
                )),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(height: 11),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(1, 33, 105, 1),
                  ),
                ),
                const SizedBox(height: 11),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(32, 32, 32, 1),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: isTextSpan
                            ? '18"x18"x18" heavy duty "Boxed Box".'
                            : "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 17),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

