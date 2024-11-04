import 'package:flutter/material.dart';
import 'package:boxed_project/Utility/color_constant.dart';

class PickupView extends StatefulWidget {
  const PickupView({Key? key}) : super(key: key);

  @override
  PickupViewState createState() => PickupViewState();
}

class PickupViewState extends State<PickupView> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBackgroundColor,
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 25),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Light grey background color
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(
                          'Customer ID:',
                          style: TextStyle(
                              color: Color.fromRGBO(102, 112, 133, 1),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        Text(
                          '0204384574',
                          style: TextStyle(
                              color: Color.fromRGBO(32, 32, 32, 1),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 25)
                      ]),
                      SizedBox(height: 8),
                      Row(children: [
                        Text(
                          'Status:',
                          style: TextStyle(
                              color: Color.fromRGBO(102, 112, 133, 1),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        SizedBox(width: 25),
                        Text(
                          'Awaiting Pickup',
                          style: TextStyle(
                              color: Color.fromRGBO(32, 32, 32, 1),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 25),
                      ]),
                    ]),
              )),
          const SizedBox(height: 15),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Light grey background color
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Are your items appropriately packed and labeled?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5.0), // Rounded corners
                                // Border color
                              ),
                              backgroundColor: ColorConstants.primaryColor,
                              foregroundColor:
                                  const Color.fromRGBO(1, 33, 105, 1),
                              side: const BorderSide(
                                  color: Color.fromRGBO(
                                      1, 33, 105, 1)), // Border color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 0.0),
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            child: const Text('Yes',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          ),
                          const SizedBox(width: 15),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5.0), // Rounded corners
                                // Border color
                              ),
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  const Color.fromRGBO(1, 33, 105, 1),
                              side: const BorderSide(
                                  color: Color.fromRGBO(
                                      1, 33, 105, 1)), // Border color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 27.0, vertical: 0.0),
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            child: const Text('No',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.primaryColor)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'If yes, click yes again below to confirm that you are ready for pickup at the slot time and location detailed above.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5.0), // Rounded corners
                                // Border color
                              ),
                              backgroundColor: ColorConstants.primaryColor,
                              foregroundColor:
                                  const Color.fromRGBO(1, 33, 105, 1),
                              side: const BorderSide(
                                  color: Color.fromRGBO(
                                      1, 33, 105, 1)), // Border color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 0.0),
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            child: const Text('Yes',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          ),
                          const SizedBox(width: 15),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5.0), // Rounded corners
                                // Border color
                              ),
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  const Color.fromRGBO(1, 33, 105, 1),
                              side: const BorderSide(
                                  color: Color.fromRGBO(
                                      1, 33, 105, 1)), // Border color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 27.0, vertical: 0.0),
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            child: const Text('No',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.primaryColor)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Click “Yes” once your items are in the possession of the movers',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5.0), // Rounded corners
                                // Border color
                              ),
                              backgroundColor: ColorConstants.primaryColor,
                              foregroundColor:
                                  const Color.fromRGBO(1, 33, 105, 1),
                              side: const BorderSide(
                                  color: Color.fromRGBO(
                                      1, 33, 105, 1)), // Border color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 0.0),
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            child: const Text('Yes',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white)),
                          ),
                          const SizedBox(width: 15),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5.0), // Rounded corners
                                // Border color
                              ),
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  const Color.fromRGBO(1, 33, 105, 1),
                              side: const BorderSide(
                                  color: Color.fromRGBO(
                                      1, 33, 105, 1)), // Border color
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 27.0, vertical: 0.0),
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            child: const Text('No',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.primaryColor)),
                          ),
                        ],
                      ),
                    ]),
              ))
        ],
      ),
    );
  }
}
