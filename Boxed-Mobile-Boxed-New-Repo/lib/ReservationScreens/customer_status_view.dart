import 'package:flutter/material.dart';
import 'package:boxed_project/Utility/color_constant.dart';

class CustomerStatusView extends StatefulWidget {
  const CustomerStatusView({super.key});

  @override
  CustomerStatusViewState createState() => CustomerStatusViewState();
}

class CustomerStatusViewState extends State<CustomerStatusView> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBackgroundColor,
      body: Column(
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
                child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Your items were securely placed in storage. Thank you for your trust with Boxed!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 20),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Customer Status: ',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 112, 133, 1),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              'SECURED IN STORAGE',
                              style: TextStyle(
                                  color: Color.fromRGBO(32, 32, 32, 1),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400),
                            ),
                          ]),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Estimated DROPOFF Day: ',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 112, 133, 1),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '8/15/2025',
                              style: TextStyle(
                                  color: Color.fromRGBO(32, 32, 32, 1),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400),
                            ),
                          ]),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Last Update/Notification: ',
                              style: TextStyle(
                                  color: Color.fromRGBO(102, 112, 133, 1),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '8/15/2025',
                              style: TextStyle(
                                  color: Color.fromRGBO(32, 32, 32, 1),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400),
                            ),
                          ]),
                    ]),
              ))
        ],
      ),
    );
  }
}
