import 'package:flutter/material.dart';
import 'package:boxed_project/Utility/color_constant.dart';

class ReservationDetailSlider extends StatefulWidget {
  const ReservationDetailSlider({Key? key}) : super(key: key);

  @override
  State<ReservationDetailSlider> createState() =>
      _ReservationDetailSliderState();
}

class _ReservationDetailSliderState extends State<ReservationDetailSlider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.primaryBackgroundColor,
        body: Expanded(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: ColorConstants
                    .primaryBackgroundColor, // Background color of ListView
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryWhiteColor,
                      borderRadius:
                          BorderRadius.circular(16.0), // Corner radius
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                16.0), // Corner radius for image container
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/sliderImages.png',
                              height: 309,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorConstants
                                .primaryWhiteColor, // Background color for data containers
                            borderRadius: BorderRadius.circular(
                                16.0), // Corner radius for data containers
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: const Row(
                            children: [
                              Text(
                                'Customer ID:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '0204384574',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                16.0), // Corner radius for data containers
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: const Row(
                            children: [
                              Text(
                                'Next Step:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Confirm Details',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.right,
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
              ),
            ],
          ),
        ));
  }
}
