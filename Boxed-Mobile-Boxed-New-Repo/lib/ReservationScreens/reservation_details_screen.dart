import 'package:boxed_project/Utility/common.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/ReservationScreens/pickup_view.dart';
import 'package:boxed_project/ReservationScreens/label_item_screen.dart';
import 'package:boxed_project/ReservationScreens/reservation_screen.dart';
import 'package:boxed_project/ReservationScreens/customer_status_view.dart';
import 'package:boxed_project/ReservationScreens/order_material_screen.dart';
import 'package:boxed_project/ReservationScreens/reservation_detail_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ReservationDetailScreen(),
    );
  }
}

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

    return Column(
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
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 15.0),
                  child: Image.asset(
                    'assets/images/boxed_logo.png',
                    height: 67,
                    width: 212,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: const [
              Center(child: ReservationDetailSlider()),
              Center(child: ReservationScreen()),
              Center(child: OrderMaterialScreen()),
              Center(child: LabelItemScreen()),
              Center(child: PickupView()),
              Center(child: CustomerStatusView()),
            ],
          ),
        ),
        Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    buildStepIndicator(true, 'Reserve', 0),
                    buildLine(0 < _currentIndex),
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

            Row(
              children: [
                SizedBox(
                    width: screenWidth / 6,
                    child: const Text('Reserve',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 12, // Adjust font size as needed
                          fontWeight:
                              FontWeight.w300, // Adjust font weight as needed
                          color: Colors.black, // Adjust color as needed
                        ))),
                SizedBox(
                    width: screenWidth / 6,
                    child: const Text('Confirm\nDetails',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12, // Adjust font size as needed
                          fontWeight:
                              FontWeight.w300, // Adjust font weight as needed
                          color: Colors.black, // Adjust color as needed
                        ))),
                SizedBox(
                    width: screenWidth / 6,
                    child: const Text('Order\nMaterials',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12, // Adjust font size as needed
                          fontWeight:
                              FontWeight.w300, // Adjust font weight as needed
                          color: Colors.black, // Adjust color as needed
                        ))),
                SizedBox(
                    width: screenWidth / 6,
                    child: const Text('Label\nItems',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12, // Adjust font size as needed
                          fontWeight:
                              FontWeight.w300, // Adjust font weight as needed
                          color: Colors.black, // Adjust color as needed
                        ))),
                SizedBox(
                    width: screenWidth / 6,
                    child: const Text('Check\nIn',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12, // Adjust font size as needed
                          fontWeight:
                              FontWeight.w300, // Adjust font weight as needed
                          color: Colors.black, // Adjust color as needed
                        ))),
                SizedBox(
                    width: screenWidth / 6,
                    child: const Text('Confirm\nPick Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12, // Adjust font size as needed
                          fontWeight:
                              FontWeight.w300, // Adjust font weight as needed
                          color: Colors.black, // Adjust color as needed
                        ))),
              ],
            ),
            const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
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
                  });
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromRGBO(1, 33, 105, 1),
                  side: const BorderSide(color: Color.fromRGBO(1, 33, 105, 1)),
                  padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                child: const Text('Next Step',
                  style: TextStyle(
                    fontSize: 14, // Adjust font size as needed
                    fontWeight: FontWeight.w400, // Adjust font weight as needed
                    color: Colors.black, // Adjust color as needed
                  ),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ],
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
