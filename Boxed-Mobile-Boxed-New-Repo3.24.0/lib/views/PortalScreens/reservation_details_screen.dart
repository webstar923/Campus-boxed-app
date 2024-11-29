import 'dart:convert';
import 'package:boxed_project/Utility/common.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/views/PortalScreens/pickup_view.dart';
import 'package:boxed_project/views/PortalScreens/label_item_screen.dart';
import 'package:boxed_project/views/PortalScreens/reservation_confirm_detailed_screen.dart';
import 'package:boxed_project/views/PortalScreens/customer_status_view.dart';
import 'package:boxed_project/views/PortalScreens/order_material_screen.dart';
import 'package:boxed_project/views/PortalScreens/reservation_detail_slider.dart';
import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/route_structure/go_router.dart';
import 'package:boxed_project/http/api_constant.dart';
import 'package:boxed_project/http/api_client.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';

class ReservationDetailScreen extends StatefulWidget {
  const ReservationDetailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReservationDetailScreenState createState() =>
      _ReservationDetailScreenState();
}

class _ReservationDetailScreenState extends State<ReservationDetailScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final item = Common.selectedMaterials;
  final TextEditingController pickupDateController = TextEditingController();
  final TextEditingController dropDateController = TextEditingController(); 
  final TextEditingController pickupLocationController = TextEditingController();
  final TextEditingController deliveryLocationController = TextEditingController();
  final List<String> stepList =['Reserve', 'Confirm Details', 'Order Materials', 'Label Items', 'Check In', 'Confirm Pick Up'];

  // Function to save Detail Data to Server
  Future<bool> saveDetailData() async {
    final url  = '${ApiConstants.baseUrl}${ApiConstants.reservations}';
    final body = jsonEncode({
        "pickup_time": pickupDateController.text,
        "dropoff_time": dropDateController.text,
        "pickup_location": pickupLocationController.text,
        "delivery_location" : deliveryLocationController.text
      });
    final response = await makeAuthenticatedRequest(url, 'PUT', body: body);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        return true;
      } else {
        return false;
      }
    } else {
      final responseData = jsonDecode(response.body);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("No Items Selected"),
          content: const Text("Please select at least one item to proceed."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

    // ignore: deprecated_member_use
    return  WillPopScope(
      onWillPop: () async {
        Go.named(context, RouteName.welcomeScreen);
        return false;
      },
      child:Column(
        children: [
          Container(
            height: 130 +
                MediaQuery.of(context)
                    .padding
                    .top, // Add status bar height to the container height
            color: ColorConstants.primaryColor,
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 15.0),
                    child: Image.asset(
                      'assets/images/boxed_logo.png',
                      height: 67,
                      width: 212,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0), // Adjust padding as needed
                    child: Text(
                      "<"+stepList[_currentIndex]+">",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) async {
                if( _currentIndex == 2 ){
                  await saveDetailData();
                  // print(result);
                  // index = result ? index: 2;
                }
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                Center(child: ReservationDetailSlider()),
                Center(child: ReservationConfirmDetailedScreen(
                  pickupDateController:pickupDateController,
                  dropDateController:dropDateController,
                  pickupLocationController:pickupLocationController,
                  deliveryLocationController:deliveryLocationController,
                  )
                ),
                Center(child: OrderMaterialScreen()),
                Center(child: LabelItemScreen()),
                Center(child: PickupView()),
                Center(child: CustomerStatusView()),
              ],
            ),
          ),
          Container(
            // color: Color.fromARGB(200, 255, 192, 203),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorConstants.primaryColor, const Color.fromARGB(255, 12, 64, 187), ColorConstants.primaryColor],  // Gradient colors
                begin: Alignment.bottomCenter,              // Start point
                end: Alignment.topCenter,            // End point
              ),
            ),
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      buildStepIndicator(true, 'Reserve', 0),
                      buildLine(0 < _currentIndex),
                      // buildStepIndicator(0 < _currentIndex, 'Order Materials', 1),
                      buildStepIndicator(0 < _currentIndex, 'Confirm Details', 1),
                      buildLine(1 < _currentIndex),
                      buildStepIndicator(1 < _currentIndex, 'Order Materials', 2),
                      buildLine(2 < _currentIndex),
                      buildStepIndicator(2 < _currentIndex, 'Label Items', 3),
                      buildLine(3 < _currentIndex),
                      buildStepIndicator(3 < _currentIndex, 'Check In', 4),
                      buildLine(4 < _currentIndex),
                      buildStepIndicator(4 < _currentIndex, 'Confirm Pick Up', 5),
                    ],
                  )),
                // Added space between indicators and labels

                // Row(
                //   children: [
                //     SizedBox(
                //         width: screenWidth / 6,
                //         child: const Text('Reserve',
                //             textAlign: TextAlign.center,
                //             softWrap: true,
                //             style: TextStyle(
                //               fontSize: 12, // Adjust font size as needed
                //               fontWeight:
                //                   FontWeight.w300, // Adjust font weight as needed
                //               color: Colors.white, // Adjust color as needed
                //             ))),
                //     SizedBox(
                //         width: screenWidth / 6,
                //         child: const Text('Confirm\nDetails',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontSize: 12, // Adjust font size as needed
                //               fontWeight:
                //                   FontWeight.w300, // Adjust font weight as needed
                //               color: Colors.white, // Adjust color as needed
                //             ))),
                //     SizedBox(
                //         width: screenWidth / 6,
                //         child: const Text('Order\nMaterials',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontSize: 12, // Adjust font size as needed
                //               fontWeight:
                //                   FontWeight.w300, // Adjust font weight as needed
                //               color: Colors.white, // Adjust color as needed
                //             ))),
                //     SizedBox(
                //         width: screenWidth / 6,
                //         child: const Text('Label\nItems',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontSize: 12, // Adjust font size as needed
                //               fontWeight:
                //                   FontWeight.w300, // Adjust font weight as needed
                //               color: Colors.white, // Adjust color as needed
                //             ))),
                //     SizedBox(
                //         width: screenWidth / 6,
                //         child: const Text('Check\nIn',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontSize: 12, // Adjust font size as needed
                //               fontWeight:
                //                   FontWeight.w300, // Adjust font weight as needed
                //               color: Colors.white, // Adjust color as needed
                //             ))),
                //     SizedBox(
                //         width: screenWidth / 6,
                //         child: const Text('Confirm\nPick Up',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontSize: 12, // Adjust font size as needed
                //               fontWeight:
                //                   FontWeight.w300, // Adjust font weight as needed
                //               color: Colors.white, // Adjust color as needed
                //             ))),
                //   ],
                // ),
                // 10.kH,
                //   OutlinedButton(
                //     onPressed: () {
                //       setState(() {
                //         if (_currentIndex == 2 && item.length <= 0) {
                //           _showAlertDialog(context);
                //         } else {
                //           if (_currentIndex < 5) {
                //             _currentIndex = _currentIndex + 1;
                //             _pageController.animateToPage(
                //               _currentIndex,
                //               duration: const Duration(milliseconds: 300),
                //               curve: Curves.easeInOut,
                //             );
                //           }
                //         }
                //       });
                //     },
                //     style: OutlinedButton.styleFrom(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(4.0),
                //       ),
                //       backgroundColor: Colors.white,
                //       foregroundColor: const Color.fromRGBO(1, 33, 105, 1),
                //       side: const BorderSide(color: Color.fromRGBO(1, 33, 105, 1)),
                //       padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
                //       textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                //     ),
                //     child: const Text('Next Step',
                //       style: TextStyle(
                //         fontSize: 14, // Adjust font size as needed
                //         fontWeight: FontWeight.w400, // Adjust font weight as needed
                //         color: Colors.black, // Adjust color as needed
                //       ),
                //     ),
                //   ),
                // Padding(padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
                //   child: CustomButton(
                //     onTap: () => {
                //       setState(() {
                //         if (_currentIndex == 2 && item.length <= 0) {
                //           _showAlertDialog(context);
                //         } else {
                //           if (_currentIndex < 5) {
                //             _currentIndex = _currentIndex + 1;
                //             _pageController.animateToPage(
                //               _currentIndex,
                //               duration: const Duration(milliseconds: 300),
                //               curve: Curves.easeInOut,
                //             );
                //           }
                //         }
                //       })
                //     },
                //     height: 55,
                //     borderRadius: BorderRadius.circular(10),
                //     child: const Text(
                //       "NEXT STEP",
                //       style: TextStyle(
                //         color: themewhitecolor,
                //         fontSize: mediumfontsize3,
                //         fontWeight: boldfontweight,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: GestureDetector(
                    onTap: () => {
                      setState(() {
                        if (_currentIndex == 2 && item.length <= 0) {
                          _showAlertDialog(context);
                        } else {
                          if (_currentIndex < 5) {
                            _currentIndex = _currentIndex + 1;
                            _pageController.animateToPage(
                              _currentIndex,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        }
                      })
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF004BA0), // Button color
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "NEXT STEP",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            decoration: TextDecoration.none
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                10.kH,
              ],
            ),
          )
          
        ],
      )
    );
  }

  Widget buildStepIndicator(bool isActive, String step, int index) {
    return GestureDetector(
      onTap: () => (index),
      child: CircleAvatar(
        radius: 12,
        backgroundColor: isActive ? Colors.green : Colors.grey[300],
        child: isActive
            ? const Icon(Icons.check, size: 16, color: Colors.white)
            : Container(),
      ),
    );
  }

  Widget buildLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.green : Colors.grey[300],
      ),
    );
  }
}
